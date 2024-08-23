#!/usr/bin/env python3

import sys, time, subprocess
import os, os.path, glob
import re
from clang import cindex
from collections import namedtuple, OrderedDict

def stderr(s):
  sys.stderr.write(s+"\n")
  sys.stderr.flush()

def usage_exit():
  argv0 = (sys.argv[:1]+["generate_bindings.py"])[0]
  stderr("Usage: %s path/to/include/xed" % argv0)
  exit(64)

if len(sys.argv) != 2:
  usage_exit()

XED_HEADERS = sys.argv[1]

if not os.path.exists(os.path.join(XED_HEADERS, "xed-interface.h")):
  usage_exit()

use_polymorphic_variants_for_enums = False

# Monkeypatch for using a slightly older clang.cindex with a new libclang.
try:
  cindex.TypeKind.ELABORATED
except AttributeError:
  cindex.TypeKind.ELABORATED = cindex.TypeKind(119)

try:
  Index = cindex.Index.create()
except cindex.LibclangError as exc:
  globs = [
    "/usr/lib/llvm-*/lib", # Linux
    "/usr/local/lib/llvm-*/lib",
    "/opt/local/libexec/llvm-*/lib", # MacPorts
    "/usr/local/opt/llvm*/lib/llvm*/lib", # Homebrew, I think?
  ]
  for llvmlib in (j for i in globs for j in glob.iglob(i)):
    cindex.Config.set_library_path(llvmlib)
    try:
      Index = cindex.Index.create()
      stderr(f"Using {llvmlib}")
      break
    except cindex.LibclangError:
      pass
  else:
    raise exc

# Concatenate the strings from the given generator, except add newlines every
# once in a while and start each line with the given prefix.
def group_into_lines(prefix, line_gen):
  assert len(prefix) < 80
  curr_line = prefix
  for elt in line_gen:
    if len(curr_line)+len(elt) > 80:
      yield curr_line
      curr_line = prefix
    curr_line += elt
  if curr_line != prefix:
    yield curr_line

#
# Parse XED headers.
#

tu = Index.parse(
  os.path.join(XED_HEADERS, "xed-interface.h"),
  args=["-I"+XED_HEADERS],
  options=cindex.TranslationUnit.PARSE_DETAILED_PROCESSING_RECORD,
)

#
# cindex helper functions.
#
def repr_func_decl(decl):
  return " ".join((decl.spelling, ":", ", ".join(j.spelling for j in decl.type.argument_types()) or "void", "->", decl.type.get_result().spelling))

def name_without_qualifiers(type):
  # AFAICT there isn't a better python API for this.
  lstrip = ('const ', 'restrict ', 'volatile ')
  rstrip = (' const', ' restrict', ' volatile')
  ret = type.spelling.strip()
  while True:
    for x in rstrip:
      if ret.endswith(x):
        ret = ret[:-len(x)].strip()
        break
    else:
      break
  if ret.endswith('*'):
    return ret
  while True:
    for x in lstrip:
      if ret.startswith(x):
        ret = ret[len(x):].strip()
        break
    else:
      break
  return ret

def is_const(type):
  if type.is_const_qualified(): # Misses typedefs.
    return True
  decl = type.get_declaration()
  if decl.kind == cindex.CursorKind.TYPEDEF_DECL:
    return is_const(decl.underlying_typedef_type)
  else:
    return False


lu2uccre = re.compile(r'(?:^|(?<=[a-zA-Z0-9])_)[a-z]')
def lu2ucc(s):
  """Convert lowercase underscore to upper camel case"""
  return re.sub(lu2uccre, lambda m: m.group(0)[-1].upper(), s)


#
# Type model
#

class BPrim(namedtuple('BPrim', ('cname', 'oname', 'kind'))):
  def valid(self):
    return bool(self.cname and self.kind)

  def __str__(self):
    return self.cname

class BEnumVal(namedtuple('BEnumVal', ('oname', 'cname', 'value'))):
  def valid(self):
    return self.cname and (self.value is not None)

  def __str__(self):
    return "%s/%s" % (self.cname, self.value)

class BEnum(namedtuple('BEnum', ('oname', 'cname', 'ctype', 'elements', 'aliases', 'has_last'))):
  def valid(self):
    return all(i is not None and i.valid() for i in self.elements)

  def __str__(self):
    return "(enum %s) %s" % (self.cname, str(self.ctype))

class BFunc(namedtuple('BFunc', ('oname', 'cname', 'types'))):
  def valid(self):
    for i in self.types:
      if i is None or not i.valid():
        return False
      if isinstance(i, BBufArg):
        if i.idx < 0 or i.idx >= len(self.types):
          return False
        if not isinstance(self.types[i.idx], BPrim):
          return False
    return True

  def __str__(self):
    return "(func " + self.cname + ") [" + ", ".join(str(i) for i in self.types) + "]"

class BTypeDef(namedtuple('BTypeDef', ('oname', 'cname', 'type'))):
  def valid(self):
    return self.cname and self.type is not None and self.type.valid()

  def __str__(self):
    return "(typedef " + self.cname + ") " + str(self.type)

class BPtr(namedtuple('BPtr', ('type', 'const'))):
  def valid(self):
    return self.type is not None and self.type.valid()

  def __str__(self):
    if self.const:
      return "(c*) " + str(self.type)
    else:
      return "(*) " + str(self.type)

  @property
  def oname(self):
    return self.type.oname + '*'

class BOpaque(namedtuple('BOpaque', ('cname', 'oname', 'size', 'align'))):
  def valid(self):
    return self.cname and self.size >= 0 and (self.align & (self.align - 1)) == 0

  def __str__(self):
    if self.align == self.size:
      return "%s:%d" % (self.cname, self.size)
    else:
      return "%s:%d:%s" % (self.cname, self.size, self.align)

# May only appear as a function arg. `idx` indicates the sibling arg
# index for buffer length. `ptr` is a BPtr. `out` indicates whether
# or not this is an output-only buffer.
class BBufArg(namedtuple('BBufArg', ('ptr', 'idx', 'out'))):
  def valid(self):
    return self.idx >= 0 and self.ptr is not None and self.ptr.valid() and not (self.out and self.ptr.const)

  def __str__(self):
    return "(buf %d) %s" % (self.idx, str(self.ptr))

  @property
  def oname(self):
    return self.ptr.type.oname + '[]'

def bmatches(btype, pattern):
  if pattern is None:
    return True

  if type(btype) != type(pattern):
    return False

  if not isinstance(btype, tuple):
    return btype == pattern

  return all(bmatches(i, j) for i, j in zip(btype, pattern))

# We use ocaml-ctypes names.
BVOID    = sys.intern('void')
BBOOL    = sys.intern('bool')
BINT     = sys.intern('int')
BUINT    = sys.intern('uint')
BSTRING  = sys.intern('string')
BBYTE    = sys.intern('char')
BSINT32  = sys.intern('int32_t')
BSINT64  = sys.intern('int64_t')
BUINT16  = sys.intern('uint16_t')
BUINT32  = sys.intern('uint32_t')
BUINT64  = sys.intern('uint64_t')

basic_prim_kinds = [
  BBOOL, BINT, BUINT, BSTRING, BBYTE, BSINT32, BSINT64, BUINT16, BUINT32, BUINT64
]

def type_is_nonvoid_basic_prim(t):
  return isinstance(t, BPrim) and t.kind in basic_prim_kinds

prim_types = [
  BPrim('void', 'unit', BVOID),
  BPrim('xed_bool_t', 'bool', BBOOL),
  BPrim('int', 'int', BINT),
  BPrim('const char *', 'string', BSTRING),
  BPrim('char', 'char', BBYTE),
  BPrim('uint8_t', 'char', BBYTE),
  BPrim('int32_t', 'Signed.Int32.t', BSINT32),
  BPrim('int64_t', 'Signed.Int64.t', BSINT64),
  BPrim('uint16_t', 'Unsigned.UInt16.t', BUINT16),
  BPrim('uint32_t', 'Unsigned.UInt32.t', BUINT32),
  BPrim('uint64_t', 'Unsigned.UInt64.t', BUINT64),
  BPrim('unsigned int', 'int', BUINT),
  BPrim('xed_uint_t', 'int', BUINT),
]

def ctype_for_prim(prim):
  if prim.kind == BUINT:
    return 'int'
  else:
    return prim.kind

cname_prim_types = {i.cname:i for i in prim_types}

def fix_enum_element_name(s, enum_name=None):
  if s == "3DNOW":
    return "AMD3DNOW"
  else:
    return s

def fix_enum_type_name(s):
  if s.startswith("xed_"):
    s = s[len("xed_"):]
  if s.endswith("_t"):
    s = s[:-len("_t")]
  if s.endswith("_enum"):
    s = s[:-len("_enum")]

  if s == "exception":
    return "iexception"
  else:
    return s

class ProcessType(object):
  def __init__(self):
    self.cache = dict()

  def __call__(self, type):
    #key = type.get_declaration().get_usr()
    key = type.spelling
    if not key:
      return self.process(type)
    try:
      return self.cache[key]
    except KeyError:
      pass
    return self.cache.setdefault(key, self.process(type))

  def process(self, type):
    t = self.process_primitive(type)
    if t is not None:
      return t

    # Maybe should use .kind more?

    pointee = type.get_pointee()
    if pointee.kind != cindex.TypeKind.INVALID:
      return BPtr(self(pointee), is_const(pointee))

    result = type.get_result()
    if result.kind != cindex.TypeKind.INVALID:
      return self.process_funcptr(type)


    decl = type.get_declaration()
    if decl.kind == cindex.CursorKind.NO_DECL_FOUND:
      return self.process_no_decl(type)

    defn = decl.get_definition()
    if defn is None:
      return self.process_opaque(decl.canonical)


    if defn.kind == cindex.CursorKind.ENUM_DECL:
      return self.process_enum(defn)
    elif defn.kind == cindex.CursorKind.TYPEDEF_DECL:
      return self.process_typedef(defn)
    elif defn.kind == cindex.CursorKind.STRUCT_DECL:
      return self.process_struct(defn)
    else:
      return self.process_other(defn)

  def process_primitive(self, type):
    return cname_prim_types.get(name_without_qualifiers(type))

  def process_funcptr(self, type):
    return None # Nope.

  def process_no_decl(self, type):
    assert False, type.spelling

  def process_opaque(self, decl):
    name = name_without_qualifiers(decl.type)
    oname = name
    if oname.startswith("struct "):
      oname = oname[len("struct "):]
    if oname.startswith("xed_") and oname.endswith("_t"):
      oname = oname[4:-2]
    return BOpaque(cname=name, oname=oname, size=decl.type.get_size(),
                                            align=decl.type.get_align())

  def process_enum(self, decl):
    assert decl.kind == cindex.CursorKind.ENUM_DECL
    enum_cname = decl.type.spelling
    enum_oname = fix_enum_type_name(enum_cname)
    if enum_oname is None:
      return
    if not enum_oname[0].islower() and not enum_oname[0] == "_":
      enum_oname = enum_oname[0].lower() + enum_oname[1:]
      if not enum_oname[0].islower():
        stderr(f"Enum {name} has bad type name {enum_oname}")
        enum_oname = "t" + enum_oname

    # Remove common enum element prefixes.
    el_prefix = None
    for i in decl.get_children():
      assert i.kind == cindex.CursorKind.ENUM_CONSTANT_DECL
      if el_prefix is None:
        el_prefix = i.spelling
      else:
        while not i.spelling.startswith(el_prefix):
          el_prefix = el_prefix[:-1]

    by_cval = OrderedDict()
    for i in decl.get_children():
      if not (-(1<<30) <= i.enum_value < (1<<30)):
        stderr(f"Excluding enum {enum_cname} {i.spelling}, can't fit in 31-bit int")
        continue
      oname = fix_enum_element_name(i.spelling[len(el_prefix):], enum_cname)
      if enum_oname == 'address_width' and oname == 'LAST':
        # Usually, LAST only exists for sequential enums, which we detect and remove below.
        # address_width is not sequential, and LAST makes no sense for it.
        continue
      by_cval.setdefault(i.enum_value, []).append(BEnumVal(oname, i.spelling, i.enum_value))

    has_last = False
    t = by_cval.get(len(by_cval)-1, None)
    if t and t[0].oname == 'LAST':
      by_cval.pop(len(by_cval)-1)
      has_last = True

    elements = []
    aliases = []
    for cval, elts in by_cval.items():
      canon = elts[0]

      oname = canon.oname
      if not oname[0].isupper():
        oname = oname[0].upper() + oname[1:]
        if not oname[0].isupper():
          new_oname = "A" + oname
          stderr(f"using {new_oname} for {oname} in enum {enum_cname}")
          oname = new_oname
      if use_polymorphic_variants_for_enums:
        oname = "`" + oname
      elements.append(canon._replace(oname=oname))
      canon_oname = oname

      for i in elts:
        if i is canon:
          continue
        oname = i.oname
        if oname.isupper():
          oname = oname.lower()
        oname = enum_oname + '_' + oname
        aliases.append(i._replace(oname=oname, value=canon_oname))

    return BEnum(enum_oname, enum_cname, self(decl.enum_type), tuple(elements), tuple(aliases), has_last)

  def process_typedef(self, decl):
    assert decl.kind == cindex.CursorKind.TYPEDEF_DECL
    underlying = self(decl.underlying_typedef_type)

    oname = decl.spelling
    oname = oname[4:-2] if oname.startswith('xed_') and oname.endswith('_t') else oname

    if hasattr(underlying, 'cname') and underlying.cname == decl.spelling:
      return underlying
    elif isinstance(underlying, BOpaque):
      return underlying._replace(cname=decl.spelling, oname=oname)
    elif isinstance(underlying, BPrim):
      return underlying._replace(cname=decl.spelling)
    else:
      return BTypeDef(cname=decl.spelling, oname=oname, type=underlying)

  def process_struct(self, decl):
    # We're treating all structs as opaque for this.
    return self.process_opaque(decl)

  def process_other(self, decl):
    return self.process_opaque(decl)

typer = ProcessType()


#
# Parse function defintions.
#

# Things that are broken or make no sense for OCaml.
unwanted_functions = {
  # String/integer utility functions
  "xed_strlen",
  "xed_strcat",
  "xed_strcpy",
  "xed_strncpy",
  "xed_strncat",
  "xed_itoa",
  "xed_itoa_bin",
  "xed_itoa_hex_zeros",
  "xed_itoa_hex",
  "xed_itoa_hex_ul",
  "xed_sign_extend32_64",
  "xed_sign_extend16_64",
  "xed_sign_extend8_64",
  "xed_sign_extend16_32",
  "xed_sign_extend8_32",
  "xed_sign_extend8_16",
  "xed_sign_extend_arbitrary_to_32",
  "xed_sign_extend_arbitrary_to_64",
  "xed_zero_extend32_64",
  "xed_zero_extend16_64",
  "xed_zero_extend8_64",
  "xed_zero_extend16_32",
  "xed_zero_extend8_32",
  "xed_zero_extend8_16",
  "xed_make_uint64",
  "xed_make_int64",
  "xed_get_byte",
  "xed_shortest_width_unsigned",
  "xed_shortest_width_signed",

  # XED stuff.
  "xed_tables_init",
  "xed_inst_table_base",
  "xed_internal_assert",
  "xed_register_abort_function",
  "xed_set_log_file",

  # Exist in headerfile, but no implementation.
  "xed_operand_values_has_disp",
  "xed_operand_values_is_prefetch",

  # Manual bindings for these.
  "xed_inst_get_attributes",
  "xed_decoded_inst_get_attributes",
  "xed_encode",
  "xed_encoder_request_init_from_decode",
  "xed_init_print_info",
  "xed_format_generic",
  "xed_format_context",
  "xed_format_set_options",
  "xed_get_cpuid_rec",
  "xed_iform_map",
  # "xed_inst",
  # "xed_inst0",
  # "xed_inst1",
  # "xed_inst2",
  # "xed_inst3",
  # "xed_inst4",
  # "xed_inst5",
}

def fix_function_name(s):
  if s in unwanted_functions:
    return None
  elif s.startswith("xed_") and s.endswith("_enum_t_last"):
    return None
  else:
    return s

func_buf_args = {
  "xed_operand_print(const xed_operand_t, char *, int)" : ((1,2,True),),
  "xed_flag_set_print(const xed_flag_set_t *, char *, int)": ((1,2,True),),
  "xed_flag_action_print(const xed_flag_action_t *, char *, int)": ((1,2,True),),
  "xed_simple_flag_print(const xed_simple_flag_t *, char *, int)": ((1,2,True),),
  "xed_state_print(const xed_state_t *, char *, int)": ((1,2,True),),
  "xed_operand_values_dump(const xed_operand_values_t *, char *, int)": ((1,2,True),),
  "xed_operand_values_print_short(const xed_operand_values_t *, char *, int)": ((1,2,True),),
  "xed_encode_request_print(const xed_encoder_request_t *, char *, xed_uint_t)": ((1,2,True),),
  "xed_decoded_inst_dump(const xed_decoded_inst_t *, char *, int)": ((1,2,True),),
  "xed_decoded_inst_dump_xed_format(const xed_decoded_inst_t *, char *, int, uint64_t)": ((1,2,True),),
  "xed_decode(xed_decoded_inst_t *, const uint8_t *, const unsigned int)": ((1,2,False),),
  "xed_ild_decode(xed_decoded_inst_t *, const uint8_t *, const unsigned int)": ((1,2,False),),
  "xed_operand_print(const xed_operand_t *, char *, int)": ((1,2,True),),
  "xed_decode_with_features(xed_decoded_inst_t *, const uint8_t *, const unsigned int, xed_chip_features_t *)": ((1,2,False),),
  "xed_encode_nop(uint8_t *, const unsigned int)": ((0,1,True),),
}

def find_buffer_args(decl):
  return func_buf_args.get(decl.displayname, ())

def process_function(decl):
  oname = fix_function_name(decl.spelling)
  if oname is None:
    return None

  args = [typer(i) for i in decl.type.argument_types()]
  args.append(typer(decl.type.get_result()))

  if None in args:
    return None

  for bufi, leni, outi in find_buffer_args(decl):
    args[bufi] = BBufArg(ptr=args[bufi], idx=leni, out=outi)

  return BFunc(oname=oname, cname=decl.spelling, types=tuple(args))

functions = []
constants = []
for decl in tu.cursor.get_children():
  if decl.kind == cindex.CursorKind.FUNCTION_DECL and decl == decl.canonical:
    x = process_function(decl)
    if x is not None:
      if x.valid():
        functions.append(x)
      else:
        # This happens with functions that take function pointer callbacks.
        stderr(f"unable to handle {x.cname}")
  if decl.kind == cindex.CursorKind.MACRO_DEFINITION and decl == decl.canonical:
    if decl.spelling.endswith('_DEFINED'): continue
    if not decl.spelling.startswith('XED_'): continue
    if not decl.spelling[4:5].isalpha(): continue
    if not decl.extent.start.file.name == decl.extent.end.file.name: continue
    with open(decl.extent.start.file.name) as f:
      start = decl.extent.start.offset + len(decl.spelling)
      f.seek(start)
      s = f.read(decl.extent.end.offset-start).strip()
    if s:
      if s[0] == '(' and s[-1] == ')':
        s = s[1:-1] # we don't bother checking for paren balance since we only take ints.
      try:
        value = int(s, 0)
      except ValueError:
        continue
      if not (-(1<<30) <= value < (1<<30)):
        stderr(f"Excluding constant {name}, can't fit in 31-bit int")
        continue
      name = decl.spelling[4:].lower()
      constants.append((name, value))

constants.sort()

def filter_funcs(func):
  for i in func.types:
    if isinstance(i, BPrim):
      pass
    elif isinstance(i, BBufArg):
      pass
    elif isinstance(i, BEnum) and isinstance(i.ctype, BPrim):
      pass
    elif isinstance(i, BPtr) and isinstance(i.type, BOpaque):
      pass
    else:
      return False
  return True

skip_funcs = {
  "xed3_set_generic_operand",
}

for func in functions:
  if not filter_funcs(func):
    # probably due to directly taking a struct, or taking a buffer we don't understand.
    # Don't care about most, we'll get the ones we do care about later.
    stderr(f"not handling {func}")

functions = [i for i in functions if filter_funcs(i) and i.cname not in skip_funcs]
functions.sort(key=lambda k: k.oname)

types = sorted({i for func in functions for i in func.types}, key=lambda k: k.oname)
enum_types = sorted({i for i in types if isinstance(i, BEnum)}, key=lambda k: k.oname)
opaque_types = sorted({i.type for i in types if isinstance(i, BPtr) and isinstance(i.type, BOpaque)}, key=lambda k: k.oname)
opaque_types += [i for i in types if isinstance(i, BOpaque) and i.cname in opaque_immediates]
struct_types = sorted({i.type for i in types if isinstance(i, BPtr) and isinstance(i.type, BOpaque)}, key=lambda k: k.oname)

def outfile(name):
  return os.path.join('.', name)

with open(outfile("XBEnums.ml"), 'w') as f:
  for enum in enum_types:
    # Sort by value so the Obj.magic (below) might work.
    constructors = list(enum.elements)
    constructors.sort(key=lambda x: x.value)

    if use_polymorphic_variants_for_enums:
      f.write(f"type {enum.oname} = [\n")
    else:
      f.write(f"type {enum.oname} =\n")

    for line in group_into_lines(" ", (" | " + i.oname for i in constructors)):
      f.write(line+"\n")

    if use_polymorphic_variants_for_enums:
      f.write("]\n")

    if enum.has_last:
      f.write(f"let {enum.oname}_len = {len(enum.elements)}\n")

    for i in enum.aliases:
      f.write(f"let {i.oname} = {i.value}\n")

    if not use_polymorphic_variants_for_enums and [i.value for i in constructors] == list(range(len(constructors))):
      # OCaml represents argumentless constructors in a type as sequential integers.
      f.write(f"let {enum.oname}_to_int : {enum.oname} -> int = Obj.magic\n")
      f.write(f"let {enum.oname}_of_int (x : int) : {enum.oname} =\n"
            + f"  if 0 <= x && x < {len(constructors)} then Obj.magic x\n"
            + f"  else failwith \"{enum.oname}_of_int: no enum for given int\"\n")
    else:
      f.write(f"let {enum.oname}_to_int : {enum.oname} -> int = function\n")
      for line in group_into_lines(" ", (" | %s -> %d" % (i.oname, i.value) for i in constructors)):
        f.write(line+"\n")
      f.write(f"let {enum.oname}_of_int : int -> {enum.oname} = function\n")
      for line in group_into_lines(" ", (" | %d -> %s" % (i.value, i.oname) for i in constructors)):
        f.write(line+"\n")
      f.write(f"  | _ -> failwith \"{enum.oname}_of_int: no enum for given int\"\n")

    f.write("\n")

with open(outfile("type_desc.ml"), 'w') as f:
  f.write(f"""\
module Types (F : Cstubs.Types.TYPE) = struct
  open F
  open struct
    type 'a abstract = 'a Ctypes.abstract
    type 'a structure = 'a Ctypes.structure
    let (%) f g = fun x -> f (g x)
""")
  of_int_to_int = {
    BBOOL   : ("function 0 -> false | _ -> true", "function true -> 1 | false -> 0"),
    BINT    : ("Signed.Int.of_int",               "Signed.Int.to_int"),
    BUINT   : ("Unsigned.UInt.of_int",            "Unsigned.UInt.to_int"),
    BBYTE   : ("Stdlib.char_of_int",              "Stdlib.int_of_char"),
    BSINT32 : ("Signed.Int32.of_int",             "Signed.Int32.to_int"),
    BSINT64 : ("Signed.Int64.of_int",             "Signed.Int64.to_int"),
    BUINT16 : ("Unsigned.UInt16.of_int",          "Unsigned.UInt16.to_int"),
    BUINT32 : ("Unsigned.UInt32.of_int",          "Unsigned.UInt32.to_int"),
    BUINT64 : ("Unsigned.UInt64.of_int",          "Unsigned.UInt64.to_int"),
  }
  for kind in {i.ctype.kind for i in enum_types}:
    f.write(f"""\
    let {kind}_of_int = {of_int_to_int[kind][0]}
    let {kind}_to_int = {of_int_to_int[kind][1]}
""")
  f.write(f"""\
  end

  (* Since ctypes doesn't have const ptrs. *)
  module Ptr : sig
    type ('a, -'perm) t
    val ro : 'a Ctypes.ptr -> ('a, [`Read]) t
    val rw : 'a Ctypes.ptr -> ('a, [`Read|`Write]) t
    val get : ('a, [`Read|`Write]) t -> 'a Ctypes.ptr
    val unsafe_get : ('a, 'perm) t -> 'a Ctypes.ptr
    val raw_address : ('a, 'perm) t -> nativeint
    val const : ('a, [>`Read]) t -> ('a, [`Read]) t
  end = struct
    type ('a, -'perm) t = 'a Ctypes.ptr
    let ro x = x
    let rw x = x
    let get x = x
    let unsafe_get x = x
    let raw_address x = Ctypes.raw_address_of_ptr @@ Ctypes.to_voidp x
    let const x = x
  end

  type encoder_operand
  let encoder_operand : encoder_operand structure typ = structure "xed_encoder_operand_t"
  type enc_displacement
  let enc_displacement : enc_displacement structure typ = structure "xed_enc_displacement_t"
""")
  for i in opaque_types:
    f.write(f"""\
  type {i.oname}
  let {i.oname} : {i.oname} abstract typ = abstract ~name:\"{i.cname}\" ~size:{i.size} ~alignment:{i.align}
  let const_{i.oname}_ptr = view ~read:Ptr.ro ~write:Ptr.unsafe_get @@ ptr {i.oname}
  let {i.oname}_ptr = view ~read:Ptr.rw ~write:Ptr.get @@ ptr {i.oname}
  type 'a {i.oname}_ptr = ({i.oname} abstract, 'a) Ptr.t
""")
  for i in enum_types:
    f.write(f"""\
  let {i.oname}_enum = view
      ~read:(XBEnums.{i.oname}_of_int % {i.ctype.kind}_to_int)
      ~write:({i.ctype.kind}_of_int % XBEnums.{i.oname}_to_int)
      @@ typedef {i.ctype.kind} "{i.cname}"
""")
#   for i in enum_types:
#     f.write(f"""\
#   let {i.oname}_enum : XBEnums.{i.oname} F.typ = F.enum "{i.cname}" ~typedef:true ([
# """)
#     for j in i.elements:
#       f.write(f"""\
#       XBEnums.{j.oname}, F.constant "{j.cname}" F.int64_t;
# """)
#     f.write(f"""\
#     ] : (XBEnums.{i.oname} * 'a) list)
# """)
  f.write("""\
end
""")

with open(outfile("function_desc.ml"), 'w') as f:
  f.write("""\
(* "Low level" binding functions, not to be exposed. *)
open Ctypes
open Types_generated
module Functions (F : Cstubs.FOREIGN) = struct
open F

""")
  def map_type(type, arg, context = ""):
    if isinstance(type, BPtr) and isinstance(type.type, BOpaque):
      return '(ptr ' + type.type.oname + ')'
    elif isinstance(type, BBufArg):
      if type.ptr.type.kind == BBYTE:
        return 'ocaml_string' if type.ptr.const else 'ocaml_bytes'
      assert False, type.ptr.type
    elif isinstance(type, BPrim):
      return ctype_for_prim(type)
    elif isinstance(type, BEnum):
      return type.oname + "_enum"
    else:
      return type.oname

  for func in functions:
    xargs = " @-> ".join(map_type(i, True) for i in func.types[:-1])
    if not xargs:
      xargs = "void"
    xres = map_type(func.types[-1], False)
    f.write(f"  let {func.oname} = foreign \"{func.cname}\" ({xargs} @-> returning {xres})\n")

  f.write("end\n")



def func_class_name_fixes(cname, default=None):
  if cname == "xed_inst_exception":
    return "iexception"
  if cname == "xed_operand_type":
    return "op_type"
  if cname == "xed_operand_operand_visibility":
    return "visibility"
  return default or cname

# Produced cnames are actually the oname used in functions.ml
func_classes = {}
enum2str_funcs = []
enuminfo_funcs = []
encoder_funcs = []
other_funcs = []
for func in functions:
  cname = func.cname

  t = "_".join(cname.split("_")[1:-2]) if cname.startswith("str2xed_") and cname.endswith("_enum_t") else ""
  if t:
    enum2str_funcs.append(func._replace(oname=t+"_of_string", cname=func.oname))
    continue
  t = "_".join(cname.split("_")[1:-2]) if cname.startswith("xed_") and cname.endswith("_enum_t2str") else ""
  if t:
    enum2str_funcs.append(func._replace(oname=t+"_to_string", cname=func.oname))
    continue

  if cname.startswith("xed_") and len(func.types) >= 2 and isinstance(func.types[0], BPtr) and isinstance(func.types[0].type, BOpaque):
    classname = func.types[0].type.oname
    t = "xed_" + classname + "_"
    method_name = None
    if cname.startswith(t):
      method_name = func_class_name_fixes(cname, cname[len(t):])
    elif cname.startswith("xed_classify"):
      method_name = func_class_name_fixes(cname, cname[4:])
    elif cname.startswith("xed_") and cname.endswith("_"+classname):
      method_name = func_class_name_fixes(cname, cname[4:])
    if method_name:
      methods = func_classes.setdefault(lu2ucc(classname), (func.types[0].type, {}))[1]
      t = func._replace(oname=method_name, cname=func.oname)
      assert methods.setdefault(method_name, t) == t, "repeat decl %r %r %r" % (classname, method_name, cname)
      continue

  if cname.startswith("xed3_operand_") and bmatches(func.types[0], BPtr(type=BOpaque(cname="xed_decoded_inst_t", oname=None, size=None, align=None), const=None)):
    methods = func_classes.setdefault("Operand3", (None, {}))[1]
    method_name = cname[len("xed3_operand_"):]
    t = func._replace(oname=method_name, cname=func.oname)
    assert methods.setdefault(method_name, t) == t, "repeat decl %r" % cname
    continue

  if (
    len(func.types) >= 2
    and isinstance(func.types[0], BEnum)
    and all(isinstance(i, BEnum) or type_is_nonvoid_basic_prim(i) for i in func.types)
  ):
    oname = func.oname
    if oname.startswith("xed_"): oname = oname[4:]
    if oname.startswith("get_"): oname = oname[4:]
    if func.types[0].oname not in oname:
      oname = func.types[0].oname + "_" + oname
    enuminfo_funcs.append(func._replace(oname=oname))
    continue

  if func.types[-1].cname in ("xed_encoder_operand_t", "xed_enc_displacement_t"):
    oname = func.oname
    if oname.startswith("xed_"):
      oname = oname[4:]
    encoder_funcs.append(func._replace(oname=oname))
    continue

  other_funcs.append(func)

enum2str_funcs.sort(key=lambda k: k.oname)
enuminfo_funcs.sort(key=lambda k: k.oname)
encoder_funcs.sort(key=lambda k: k.oname)
other_funcs.sort(key=lambda k: k.oname)

with open(outfile("bind.ml"), 'w') as f:
  f.write("""\
module Funcs = C.Function
module Types = Types_generated
module Ptr = Types.Ptr

""")

  def trans(func, indent="", method=None):
    xargs = []
    pre = []
    asserts = []
    yargs = []
    retval = None

    bufsize_idxs = {}

    for i, arg in enumerate(func.types[:-1]):
      if isinstance(arg, BBufArg):
        bufsize_idxs.setdefault(arg.idx, []).append(i)

    for i, arg in enumerate(func.types[:-1]):
      name = "a%d" % i
      if i == 0 and method and func.oname.startswith("init"):
        assert func.types[-1].kind == BVOID
        pre.append(f"let {name} = uninit () in")
        yargs.append(f"(Ptr.get {name})")
        assert not retval
        retval = name
        rettype = "[<`Read|`Write] t"
      elif i in bufsize_idxs:
        lengths = []
        for x in bufsize_idxs[i]:
          t = "String" if func.types[x].ptr.const else "Bytes"
          lengths.append(f"{t}.length a{x}")
        if len(lengths) <= 1:
          yargs.append("(" + lengths[0] + ")")
        else:
          pre.append(f"let {name} = {lengths[0]} in")
          for x in lengths[1:]:
            asserts.append(f"{x} = {name}")
          yargs.append(name)
      elif isinstance(arg, BBufArg):
        xargs.append(f"({name} : {'string' if arg.ptr.const else 'bytes'})")
        t = "ocaml_string_start" if arg.ptr.const else "ocaml_bytes_start"
        yargs.append(f"(Ctypes.{t} {name})")
      elif isinstance(arg, BPtr) and isinstance(arg.type, BOpaque):
        xargs.append(f"({name} : {'[>`Read]' if arg.const else '[>`Read|`Write]'} Types.{arg.type.oname}_ptr)")
        yargs.append(f"(Ptr.unsafe_get {name})")
      elif isinstance(arg, BEnum):
        xargs.append(f"({name} : XBEnums.{arg.oname})")
        yargs.append(name)
      else:
        xargs.append(f"({name} : {arg.oname})")
        yargs.append(name)

      if isinstance(arg, BPrim) and arg.kind is BUINT and i not in bufsize_idxs:
        asserts.append(name + " >= 0")

    ret = func.types[-1]
    cast = ""
    if retval:
      assert rettype
    elif isinstance(ret, BPtr) and isinstance(ret.type, BOpaque):
      rettype = f"{'[<`Read]' if ret.const else '[<`Read|`Write]'} Types.{ret.type.oname}_ptr"
      cast = " |> Ptr.ro" if ret.const else " |> Ptr.rw"
    elif isinstance(ret, BEnum):
      rettype = f"XBEnums.{ret.oname}"
    else:
      rettype = ret.oname

    return (
      f"{indent}let {func.oname} {' '.join(xargs or ('()',))} : {rettype} =\n" +
      "".join(f"{indent} {i}\n" for i in pre) +
      (f"{indent}  assert ({' && '.join(asserts)});\n" if asserts else "") +
      f"{indent}  Funcs.{func.cname} " + " ".join(yargs or ("()",)) + cast +
      (f";\n{indent}  {retval}\n" if retval else "\n")
    )

  for module_name in sorted(func_classes.keys()):
    typ, methods = func_classes[module_name]
    f.write(f"module {module_name} = struct\n")
    if typ is not None:
      f.write(f"  type -'perm t = (Types.{typ.oname} Ctypes.abstract, 'perm) Ptr.t\n")
      f.write(f"  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.{typ.oname}\n")
    for func in sorted(methods.values()):
      f.write(trans(func, indent="  ", method=module_name))
    f.write("end\n\n")

  f.write("\n")

  f.write("module Constants = struct\n")
  for name, value in constants:
    f.write(f"  let {name} = {value}\n")
  f.write("end\n")

  f.write("\n")

  f.write("module Enum = struct\n")
  f.write("  include XBEnums\n")
  for func in enum2str_funcs:
    f.write(trans(func, indent="  "))
  for func in enuminfo_funcs:
    f.write(trans(func, indent="  "))
  f.write("end\n")

  f.write("\n")

  # This is currently empty. Probably just remove it?
  f.write("module Enc = struct\n")
  for func in encoder_funcs:
    f.write(trans(func, indent="  "))
  f.write("end\n")

  if other_funcs:
    f.write("\n(* other *)\n")
  for func in other_funcs:
    f.write(trans(func))
