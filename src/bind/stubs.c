#include <string.h>
#include <xed-interface.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/fail.h>

value xb_disassemble(value syntax_int, value decoded_inst, value addr) {
  CAMLparam3(syntax_int, decoded_inst, addr);
  char buf[480]; // big buffer cuz fully-explicit XED syntax can be verbose.
  xed_syntax_enum_t syntax = Int_val(syntax_int);
  const xed_decoded_inst_t *xedd = (void *)Nativeint_val(decoded_inst);
  xed_uint64_t address = Int64_val(addr);
  if(!xed_format_context(syntax, xedd, buf, sizeof buf, address, 0, 0)) {
    caml_failwith("Failed to disassemble");
  }
  buf[(sizeof buf) - 1] = 0; // Probably not necessary.
  CAMLreturn(caml_copy_string(buf));
}

value xb_encode(value encoder_request) {
  CAMLparam1(encoder_request);
  CAMLlocal2(outtup, outstr);

  xed_encoder_request_t *req = (void *)Nativeint_val(encoder_request);

  xed_uint8_t buf[XED_MAX_INSTRUCTION_BYTES];
  unsigned olen;
  xed_error_enum_t err = xed_encode(req, buf, XED_MAX_INSTRUCTION_BYTES, &olen);

  outstr = caml_alloc_initialized_string(olen, (const char *)buf);
  outtup = caml_alloc_tuple(2);
  Store_field(outtup, 0, Val_int(err));
  Store_field(outtup, 1, outstr);
  CAMLreturn(outtup);
}

value xb_encoder_request_init_from_decode(value encoder_request, value decoded_inst) {
  CAMLparam2(encoder_request, decoded_inst);
  xed_encoder_request_t *req = (void *)Nativeint_val(encoder_request);
  const xed_decoded_inst_t *xedd = (void *)Nativeint_val(decoded_inst);
  *req = *xedd;
  xed_encoder_request_init_from_decode(req);
  CAMLreturn(Val_unit);
}

value xb_attrs_to_list(xed_attributes_t attrs) {
  int i;
  CAMLparam0();
  CAMLlocal2(t, list);

  list = Val_int(0);
  for(i = 0; i < 128; i++) {
    xed_uint64_t val;
    int bit;
    if(i < 64) {
      val = attrs.a1;
      bit = i;
    } else {
      val = attrs.a2;
      bit = i - 64;
    }

    if((val >> bit) & 1) {
      t = caml_alloc(2, 0);
      Store_field(t, 0, Val_int(i));
      Store_field(t, 1, list);
      list = t;
    }
  }

  CAMLreturn(list);
}

value xb_inst_get_attributes(value inst) {
  CAMLparam1(inst);
  const xed_inst_t *xedi = (void *)Nativeint_val(inst);
  CAMLreturn(xb_attrs_to_list(xed_inst_get_attributes(xedi)));
}

value xb_decoded_inst_get_attributes(value decoded_inst) {
  CAMLparam1(decoded_inst);
  const xed_decoded_inst_t *xedd = (void *)Nativeint_val(decoded_inst);
  CAMLreturn(xb_attrs_to_list(xed_decoded_inst_get_attributes(xedd)));
}

// value xb_xed_inst(value encoder_inst, value state, value iclass, value effective_operand_width, value noperands, value operands) {
//   xed_encoder_instruction_t *xede = (void *)Nativeint_val(encoder_inst);
//   xed_state_t *mode = (void *)Nativeint_val(state);
//   xed_iclass_enum_t icls = Int_val(iclass);
//   xed_uint_t op_width = Int_val(effective_operand_width);
//   xed_uint_t op_count = Int_val(noperands);
//   const xed_encoder_operand_t **ops = (void *)Nativeint_val(state);
//   xed_inst(inst)
// }
