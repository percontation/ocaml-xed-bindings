#include <string.h>
#include <xed-interface.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/fail.h>

value xb_disassemble(value syntax_int, value decoded_inst, value addr) {
  CAMLparam3(syntax_int, decoded_inst, addr);
  char buf[100];
  xed_syntax_enum_t syntax = Int_val(syntax_int);
  const xed_decoded_inst_t *xedd = (void *)Nativeint_val(decoded_inst);
  xed_uint64_t address = Int64_val(addr);
  if(!xed_format_context(syntax, xedd, buf, sizeof buf, address, 0, 0)) {
    caml_failwith("Failed to disassemble");
  }
  buf[(sizeof buf) - 1] = 0; // Probably not necessary.
  CAMLreturn(caml_copy_string(buf));
}
