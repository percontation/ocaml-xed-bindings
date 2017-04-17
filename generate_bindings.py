#!/usr/bin/env python2.7

import sys, time, subprocess
import os, os.path, glob
import re
from clang import cindex
from collections import namedtuple

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
      print >> sys.stderr, "Using", llvmlib
      break
    except cindex.LibclangError:
      pass
  else:
    raise exc


#
# Parse XED headers.
#
def xedfile(path):
  return os.path.join(os.path.dirname(__file__), "xed", path)

args = ["-I"+xedfile("obj"), "-I"+xedfile("include/public/xed")]
tu = Index.parse(xedfile("include/public/xed/xed-interface.h"), args=args)


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

class BEnumVal(namedtuple('BEnumVal', ('oname', 'cname', 'cval'))):
  def valid(self):
    return self.cname and (self.cval is not None)

  def __str__(self):
    return "%s/%d" % (self.cname, self.cval)

class BEnum(namedtuple('BEnum', ('oname', 'cname', 'ctype', 'elements'))):
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

class BOpaque(namedtuple('BOpaque', ('cname', 'oname', 'size'))):
  def valid(self):
    return self.cname and self.size >= 0

  def __str__(self):
    return "%s:%d" % (self.cname, self.size)

# May only appear as a function arg. `idx` indicates the sibling arg
# index for buffer length. `ptr` is a BPtr. `out` indicates whether
# or not this is an output-only buffer.
class BBufArg(namedtuple('BBufArg', ('ptr', 'idx', 'out'))):
  def valid(self):
    return self.idx >= 0 and self.ptr is not None and self.ptr.valid() and not (self.out and self.ptr.const)

  def __str__(self):
    return "(buf %d) %s" % (self.idx, str(self.ptr))


def bmatches(btype, pattern):
  if pattern is None:
    return True

  if type(btype) != type(pattern):
    return False

  if not isinstance(btype, tuple):
    return btype == pattern

  return all(bmatches(i, j) for i, j in zip(btype, pattern))

# We use ocaml-ctypes names.
BVOID    = intern('void')
BBOOL    = intern('bool')
BINT     = intern('int')
BUINT    = intern('uint')
BSTRING  = intern('string')
BBYTE    = intern('char')
BSINT32  = intern('int32_t')
BSINT64  = intern('int64_t')
BUINT16  = intern('uint16_t')
BUINT32  = intern('uint32_t')
BUINT64  = intern('uint64_t')

prim_types = [
  BPrim('void', 'unit', BVOID),
  BPrim('xed_bool_t', 'bool', BBOOL),
  BPrim('int', 'int', BINT),
  BPrim('const char *', 'string', BSTRING),
  BPrim('char', 'char', BBYTE),
  BPrim('uint8_t', 'char', BBYTE),
  BPrim('int32_t', 'Signed.Int32.t', BSINT32),
  BPrim('int64_t', 'Signed.Int64.t', BSINT64),
  BPrim('uint16_t', 'Unsigned.UInt16.t', BUINT32),
  BPrim('uint32_t', 'Unsigned.UInt32.t', BUINT32),
  BPrim('uint64_t', 'Unsigned.UInt64.t', BUINT64),
  BPrim('unsigned int', 'int', BUINT),
  BPrim('xed_uint_t', 'int', BUINT),
  #BPrim('xed_attributes_t', 'attribute list', ???),
]

def ctype_for_prim(prim):
  if prim.kind == BUINT:
    return 'int'
  else:
    return prim.kind

cname_prim_types = {i.cname:i for i in prim_types}

def fix_enum_element_name(s, enum_name=None):
  if s == "LAST":
    return None
  elif s == "3DNOW":
    return "AMD3DNOW"
  else:
    return s

def fix_enum_type_name(s):
  if s.startswith("xed_"):
    s = s[len("xed_"):]
  if s.endswith("_t"):
    s = s[:-len("_t")]
  # if s.endswith("_enum"):
  #   s = s[:-len("_enum")]

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
    return BOpaque(cname=name, oname=oname, size=decl.type.get_size())

  def process_enum(self, decl):
    assert decl.kind == cindex.CursorKind.ENUM_DECL
    enum_cname = decl.type.spelling
    enum_oname = fix_enum_type_name(enum_cname)
    if enum_oname is None:
      return
    if not enum_oname[0].islower() and not enum_oname[0] == "_":
      enum_oname = enum_oname[0].lower() + enum_oname[1:]
      if not enum_oname[0].islower():
        print >> sys.stderr, "Enum", name, "has bad type name", enum_oname
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

    vals = []
    for i in decl.get_children():
      oname = fix_enum_element_name(i.spelling[len(el_prefix):], enum_cname)
      if oname is not None:
        if not oname[0].isupper():
          oname = oname[0].upper() + oname[1:]
          if not oname[0].isupper():
            new_oname = "A" + oname
            print >> sys.stderr, "Enum %s has bad constructor name %s, using %s" % (enum_cname, oname, new_oname)
            oname = new_oname
        vals.append(BEnumVal(oname, i.spelling, i.enum_value))

    return BEnum(enum_oname, enum_cname, self(decl.enum_type), tuple(vals))

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

unwanted_functions = {
  "xed_strlen",
  "xed_strcat",
  "xed_strcpy",
  "xed_strncpy",
  "xed_strncat",
  "xed_internal_assert",
  "xed_register_abort_function",
  "xed_itoa",
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

  # Exist in headerfile, but no implementation.
  "xed_operand_values_has_disp",
  "xed_operand_values_is_prefetch",
}

def fix_function_name(s):
  if s in unwanted_functions:
    return None
  elif s.startswith("xed_") and s.endswith("_enum_t_last"):
    return None
  else:
    return s

print_funcs_buf_args = {
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
}

def find_buffer_args(decl):
  return print_funcs_buf_args.get(decl.displayname, ())

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
for decl in tu.cursor.get_children():
  if decl.kind == cindex.CursorKind.FUNCTION_DECL and decl == decl.canonical:
    x = process_function(decl)
    if x is not None:
      if x.valid():
        functions.append(x)
      else:
        # This happens with functions that take function pointer callbacks.
        print >> sys.stderr, "unable to handle", x.cname

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
  "xed_iform_map",
  "xed3_set_generic_operand",
  "xed_encoder_request_init_from_decode",
  "xed_encode_request_print",
  "xed_init_print_info",
  "xed_format_generic",
  "xed_get_cpuid_rec",
  "xed_addr",
  "xed_rep",
  "xed_repne",
  "xed_convert_to_encoder_request",
}

for func in functions:
  if not filter_funcs(func):
    # probably due to directly taking a struct, or taking a buffer we don't understand.
    # Don't care about most, we'll get the ones we do care about later.
    print >> sys.stderr, "not handling", func

functions = [i for i in functions if filter_funcs(i) and i.cname not in skip_funcs]

types = {i for func in functions for i in func.types}
enum_types = {i for i in types if isinstance(i, BEnum)}
opaque_ptrs = {i for i in types if isinstance(i, BPtr) and isinstance(i.type, BOpaque)}


def outfile(name):
  return os.path.join(os.path.dirname(__file__), "generated", name)


enum_ctypes_views = []
with open(outfile("XedBindingsEnums.ml"), 'w') as f:
  for enum in enum_types:
    already_vals = {}
    constructors = []
    aliases = []
    for i in enum.elements:
      if i.cval not in already_vals:
        already_vals[i.cval] = i
        constructors.append(i)
      else:
        aliases.append(i)

    # Sort by value instead of by name so the Obj.magic (below) might work.
    constructors.sort(key=lambda x: x.cval)

    print >> f, "type %s =" % enum.oname
    i = 0
    while i < len(constructors):
      line = " "
      while i < len(constructors):
        new_line = line + " | " + constructors[i].oname
        if len(new_line) < 80 or not line.strip():
          line = new_line
          i += 1
        else:
          break
      print >> f, line

    for i in aliases:
      print >> f, "let %s = %s" % (i.oname.lower(), already_vals[i.cval].oname)

    if [i.cval for i in constructors] == range(len(constructors)):
      # OCaml represents argumentless constructors in a type as sequential integers.
      print >> f, "let %s_to_int : %s -> int = Obj.magic" % (enum.oname, enum.oname)
      print >> f, "let %s_of_int : int -> %s = Obj.magic" % (enum.oname, enum.oname)
    else:
      print >> f, "let %s_to_int = function" % enum.oname
      for i in constructors:
        print >> f, "  | %s -> %d" % (i.oname, i.cval)
      print >> f, "let %s_of_int = function" % enum.oname
      for i in constructors:
        print >> f, "  | %d -> %s" % (i.cval, i.oname)
      print >> f, "  | _ -> failwith \"%s_of_int: no enum for given int\"" % enum.oname

    enum_ctypes_views.append(
      "let %s = XedBindingsEnums.(view ~read:%s_of_int ~write:%s_to_int int)" %
        (enum.oname, enum.oname, enum.oname)
    )

    print >> f, ""

struct_ctypes_views = []
with open(outfile("XedBindingsStructs.ml"), 'w') as f:
  print >> f, "(* 'a [`C] myptr is const; 'a [`M] myptr is non const. The reason for this"
  print >> f, "   representation is that polymorphic variants are the only way to get cross-"
  print >> f, "   module automatic subtyping (that I could find, as of 4.04), which allows"
  print >> f, "   using writing signatures that accept const or mutable. The generated Ctypes"
  print >> f, "   module support this, but our (generated) wrapper module can. *)"
  print >> f, "type (+'a, +'b) myptr"
  print >> f, "let const : ('a, [<`M|`C]) myptr -> ('a, [`C]) myptr = Obj.magic"
  print >> f, "let _allocate n : ('a, [`M]) myptr = Ctypes.allocate_n Ctypes.char n |> Obj.magic\n"
  for i in sorted({i.type for i in opaque_ptrs}):
    module_name = lu2ucc(i.oname)
    print >> f, "module %s = struct" % module_name
    print >> f, "  type _t"
    print >> f, "  type +'a t = (_t, 'a) myptr"
    print >> f, "  let allocate () : [`M] t = _allocate %d |> Obj.magic" % i.size
    print >> f, "end"
    fmt1 = "let %s  : [`C] XedBindingsStructs.%s.t typ = view ~read:Obj.magic ~write:Obj.magic @@ ptr (typedef void \"const %s\")"
    fmt2 = "let %s' : [`M] XedBindingsStructs.%s.t typ = view ~read:Obj.magic ~write:Obj.magic @@ ptr (typedef void \"%s\")"
    struct_ctypes_views.append(fmt1 % (i.oname, module_name, i.cname))
    struct_ctypes_views.append(fmt2 % (i.oname, module_name, i.cname))

with open(outfile("XedBindingsStubs.ml"), 'w') as f:
  print >> f, "(* \"Low level\" binding functions, not to be exposed. *)"
  print >> f, "open Ctypes"
  print >> f, ""
  print >> f, "\n".join(enum_ctypes_views)
  print >> f, "\n".join(struct_ctypes_views)
  print >> f, ""
  print >> f, "module Bindings (F : Cstubs.FOREIGN) = struct"
  print >> f, "  open F\n"

  def map_type(type, context = ""):
    if isinstance(type, BPtr) and isinstance(type.type, BOpaque):
      return type.type.oname if type.const else type.type.oname + "'"
    elif isinstance(type, BBufArg):
      if type.ptr.type.kind == BBYTE:
        return 'ocaml_string' if type.ptr.const else 'ocaml_bytes'
      assert False, type.ptr.type
    elif isinstance(type, BPrim):
      return ctype_for_prim(type)
    else:
      return type.oname

  for func in sorted(functions, key=lambda x: x.oname):
    xargs = " @-> ".join(map_type(i) for i in func.types[:-1])
    if not xargs:
      xargs = "void"
    xres = map_type(func.types[-1])
    print >> f, "  let %s = foreign \"%s\" (%s @-> returning %s)" % (func.oname, func.cname, xargs, xres)

  print >> f, "end"



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
other_funcs = []
for func in functions:
  cname = func.cname

  t = "_".join(cname.split("_")[1:-2]) if cname.startswith("str2xed_") and cname.endswith("_enum_t") else ""
  if t:
    enum2str_funcs.append(func._replace(oname="%s_enum_of_string" % t, cname=func.oname))
    continue
  t = "_".join(cname.split("_")[1:-2]) if cname.startswith("xed_") and cname.endswith("_enum_t2str") else ""
  if t:
    enum2str_funcs.append(func._replace(oname="%s_enum_to_string" % t, cname=func.oname))
    continue

  if len(func.types) >= 2 and isinstance(func.types[0], BPtr) and isinstance(func.types[0].type, BOpaque):
    classname = func.types[0].type.oname
    t = "xed_" + classname + "_"
    if cname.startswith(t):
      method_name = func_class_name_fixes(cname, cname[len(t):])
    elif cname.startswith("xed_") and cname.endswith(classname):
      method_name = func_class_name_fixes(cname, cname[4:-len(classname)-1])
    else:
      method_name = None
    if method_name:
      methods = func_classes.setdefault(lu2ucc(classname), (func.types[0].type, {}))[1]
      assert method_name not in methods, "duplicate decl? (%r, %r, %r)" % (classname, method_name, cname)
      methods[method_name] = func._replace(oname=method_name, cname=func.oname)
      continue

  if cname.startswith("xed3_operand_") and bmatches(func.types[0], BPtr(type=BOpaque(cname="xed_decoded_inst_t", oname=None, size=None), const=None)):
    methods = func_classes.setdefault("Operand3", (None, {}))[1]
    method_name = cname[len("xed3_operand_"):]
    assert method_name not in methods, "duplicate decls are not handled"
    methods[method_name] = func._replace(oname=method_name, cname=func.oname)
    continue

  other_funcs.append(func)


with open(outfile("XedBindingsApi.ml"), 'w') as f:
  print >> f, "module Bindings = XedBindingsStubs.Bindings(XedBindingsGenerated)"
  print >> f, ""

#   """module Bindings = XedBindingsStubs.Bindings(struct
#   type 'a fn = 'a Ctypes.fn
#   type 'a return = 'a
#   let (@->) = Ctypes.(@->)
#   let returning = Ctypes.returning
#   type 'a result = 'a
#   let foreign x y z = Foreign.foreign x y z
#   let foreign_value x y = Foreign.foreign_value x y
# end)"""

  def trans(func, indent="", method=None):
    xargs = []
    pre = []
    asserts = []
    yargs = []
    post = ""

    bufsize_idxs = {}

    for i, arg in enumerate(func.types[:-1]):
      if isinstance(arg, BBufArg):
        bufsize_idxs.setdefault(arg.idx, []).append(i)

    def name_opaque_ptr(x, const, mutable):
      mod = lu2ucc(x.type.oname)
      t = " XedBindingsStructs." + mod + ".t" if mod != method else " t"
      if x.const:
        return const + t
      else:
        return mutable + t

    for i, arg in enumerate(func.types[:-1]):
      name = "a%d" % i
      if i == 0 and method and func.oname.startswith("init"):
        assert func.types[-1].kind == BVOID
        pre.append("let %s = allocate () in" % name)
        yargs.append("(Obj.magic %s)" % name)
        assert not post
        post = "; %s" % name
      elif i in bufsize_idxs:
        lengths = []
        for x in bufsize_idxs[i]:
          t = "String" if func.types[x].ptr.const else "Bytes"
          lengths.append("%s.length a%d" % (t, x))
        if lengths <= 1:
          yargs.append("(" + lengths[0] + ")")
        else:
          pre.append("let %s = %s in" % (name, lengths[0]))
          for x in lengths[1:]:
            asserts.append("%s = %s" % (x, name))
          yargs.append(name)
      elif isinstance(arg, BBufArg):
        xargs.append(name)
        t = "ocaml_string_start" if arg.ptr.const else "ocaml_bytes_start"
        yargs.append("(Ctypes.%s %s)" % (t, name))
      elif isinstance(arg, BPtr) and isinstance(arg.type, BOpaque):
        xargs.append("(%s : %s)" % (name, name_opaque_ptr(arg, "[<`C|`M]", "[<`M]")))
        yargs.append("(Obj.magic %s)" % name)
      else:
        xargs.append(name)
        yargs.append(name)

      if isinstance(arg, BPrim) and arg.kind is BUINT:
        asserts.append(name + " >= 0")

    if not pre and not post and not asserts and xargs == yargs:
      return indent + "let %s = Bindings.%s" % (func.oname, func.cname)
    else:
      return (
        indent + "let %s %s =\n" % (func.oname, " ".join(xargs or ("()",))) +
        "".join(indent + "  "+i+"\n" for i in pre) +
        (indent + "  assert (%s);\n" % " && ".join(asserts) if asserts else "") +
        indent + "  Bindings.%s %s" % (func.cname, " ".join(yargs or ("()",))) + post
      )

  for module_name in sorted(func_classes.iterkeys()):
    typ, methods = func_classes[module_name]
    print >> f, "module %s = struct" % module_name
    if typ is not None:
      print >> f, "  include XedBindingsStructs.%s" % module_name
    for func in sorted(methods.itervalues()):
      print >> f, trans(func, indent="  ", method=module_name)
    print >> f, "end\n"

  print >> f, ""

  print >> f, "module Enum = struct"
  print >> f, "  include XedBindingsEnums"
  for func in enum2str_funcs:
    print >> f, trans(func, indent="  ")
  print >> f, "end"

  if other_funcs:
    print >> f, "\n(* other *)"
  for func in other_funcs:
    print >> f, trans(func)

# for i in other_funcs:
#   print i.cname, ', '.join(str(j) for j in i.types)
