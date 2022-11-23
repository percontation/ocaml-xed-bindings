#include <string.h>
#include <xed-interface.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/callback.h>

xed_format_options_t xb_format_options_from_ocaml(value flags) {
  int x = Int_val(flags);
  xed_format_options_t options = {
    .hex_address_before_symbolic_name = x & (1<<0),
    .xml_a                            = x & (1<<1),
    .xml_f                            = x & (1<<2),
    .omit_unit_scale                  = x & (1<<3),
    .no_sign_extend_signed_immediates = x & (1<<4),
    .write_mask_curly_k0              = x & (1<<5),
    .lowercase_hex                    = x & (1<<6),
    .positive_memory_displacements    = x & (1<<7),
  };
  return options;
}

int xb_format_callback(xed_uint64_t address, char *symbol_buffer, xed_uint32_t buffer_length, xed_uint64_t *offset, void *context) {
  CAMLparam0();
  CAMLlocal1(v);

  v = caml_copy_int64(address);

  // Exceptions don't return, the rest of the C execution is dropped.
  // XED doesn't allocate memory, so it shouldn't have a problem with this.
  v = caml_callback(Some_val((value)context), v);

  // Note: passing buffer_length to the callback would give OCaml the opprotunity
  // to avoid the silent truncation to buffer_length that follows, but this seems
  // excessive give that in the current XED version buffer_length is always 512.

  if(Is_none(v) || buffer_length == 0) {
    // buffer_length == 0 never happens, but, we do use this assumption later.
    CAMLreturnT(int, 0);
  }

  v = Some_val(v);
  *offset = Int64_val(Field(v, 1));
  v = Field(v, 0); // string name

  // plus one to include the terminal null byte, which is there.
  size_t len = caml_string_length(v) + 1;
  if(len > buffer_length) {
    len = buffer_length-1;
    symbol_buffer[len] = 0;
  }
  memcpy(symbol_buffer, String_val(v), len);

  CAMLreturnT(int, 1);
}

value xb_format(value syntax_int, value decoded_inst, value addr, value format, value symbolizer) {
  char buf[1000]; // big buffer because fully-explicit XED syntax can be verbose.
  CAMLparam5(syntax_int, decoded_inst, addr, format, symbolizer);

  xed_print_info_t info;
  xed_init_print_info(&info);
  info.p = (void *)Nativeint_val(decoded_inst);
  info.runtime_address = Int64_val(addr);
  info.syntax = Int_val(syntax_int);

  info.buf = buf;
  info.blen = (sizeof buf) - 1;

  if(Is_none(symbolizer)) {
    info.disassembly_callback = NULL;
    info.context = NULL;
  } else {
    info.disassembly_callback = xb_format_callback;
    info.context = (void*)symbolizer;
  }
  info.format_options_valid = 1;
  info.format_options = xb_format_options_from_ocaml(format);

  buf[0] = 0; // Unclear if XED requires this; can't hurt though.

  // NB: xb_format_callback may raise an exception, so the rest of this
  // function doesn't necessarily execute.
  if(!xed_format_generic(&info)) {
    // AFAICT this is never supposed to happen for properly constructed
    // decoded_inst and info struct.
    caml_failwith("xed_format_generic");
  }
  buf[(sizeof buf) - 1] = 0; // ensure null terminated.
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

value xb_get_cpuid_rec(value cpuid_bit_int) {
  CAMLparam1(cpuid_bit_int);
  CAMLlocal1(ret);
  xed_cpuid_bit_enum_t cpuid_bit = Int_val(cpuid_bit_int);
  xed_cpuid_rec_t p;
  xed_get_cpuid_rec(cpuid_bit, &p);
  ret = caml_alloc_tuple(4);
  Store_field(ret, 0, Val_int(p.leaf));
  Store_field(ret, 1, Val_int(p.subleaf));
  Store_field(ret, 2, Val_int(p.reg));
  Store_field(ret, 3, Val_int(p.bit));
  CAMLreturn(ret);
}
