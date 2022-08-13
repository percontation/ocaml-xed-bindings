module Bindings = XedBindingsStubs.Bindings(XedBindingsGenerated)

module ChipFeatures = struct
  include XedBindingsStructs.ChipFeatures
  let get_chip_features (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.chip) : unit =
    Bindings.xed_get_chip_features (Obj.magic a0) a1
  let modify_chip_features (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.isa_set) (a2 : bool) : unit =
    Bindings.xed_modify_chip_features (Obj.magic a0) a1 a2
end

module DecodedInst = struct
  include XedBindingsStructs.DecodedInst
  let avx512_dest_elements (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_avx512_dest_elements (Obj.magic a0)
  let classify_amx (a0 : [>`Read] t) : bool =
    Bindings.xed_classify_amx (Obj.magic a0)
  let classify_avx (a0 : [>`Read] t) : bool =
    Bindings.xed_classify_avx (Obj.magic a0)
  let classify_avx512 (a0 : [>`Read] t) : bool =
    Bindings.xed_classify_avx512 (Obj.magic a0)
  let classify_avx512_maskop (a0 : [>`Read] t) : bool =
    Bindings.xed_classify_avx512_maskop (Obj.magic a0)
  let classify_sse (a0 : [>`Read] t) : bool =
    Bindings.xed_classify_sse (Obj.magic a0)
  let conditionally_writes_registers (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_conditionally_writes_registers (Obj.magic a0)
  let decode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : string) : XedBindingsEnums.error =
    Bindings.xed_decode (Obj.magic a0) (Ctypes.ocaml_string_start a1) (String.length a1)
  let decode_with_features (a0 : [>`Read|`Write of [`Yes]] t) (a1 : string) (a3 : [>`Read|`Write of [`Yes]] XedBindingsStructs.ChipFeatures.t) : XedBindingsEnums.error =
    Bindings.xed_decode_with_features (Obj.magic a0) (Ctypes.ocaml_string_start a1) (String.length a1) (Obj.magic a3)
  let dump (a0 : [>`Read] t) (a1 : bytes) : unit =
    Bindings.xed_decoded_inst_dump (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let dump_xed_format (a0 : [>`Read] t) (a1 : bytes) (a3 : Unsigned.UInt64.t) : bool =
    Bindings.xed_decoded_inst_dump_xed_format (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1) a3
  let get_attribute (a0 : [>`Read] t) (a1 : XedBindingsEnums.attribute) : Unsigned.UInt32.t =
    Bindings.xed_decoded_inst_get_attribute (Obj.magic a0) a1
  let get_base_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_base_reg (Obj.magic a0) a1
  let get_branch_displacement (a0 : [>`Read] t) : Signed.Int32.t =
    Bindings.xed_decoded_inst_get_branch_displacement (Obj.magic a0)
  let get_branch_displacement_width (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_branch_displacement_width (Obj.magic a0)
  let get_branch_displacement_width_bits (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_branch_displacement_width_bits (Obj.magic a0)
  let get_byte (a0 : [>`Read] t) (a1 : int) : char =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_byte (Obj.magic a0) a1
  let get_category (a0 : [>`Read] t) : XedBindingsEnums.category =
    Bindings.xed_decoded_inst_get_category (Obj.magic a0)
  let get_extension (a0 : [>`Read] t) : XedBindingsEnums.extension =
    Bindings.xed_decoded_inst_get_extension (Obj.magic a0)
  let get_iclass (a0 : [>`Read] t) : XedBindingsEnums.iclass =
    Bindings.xed_decoded_inst_get_iclass (Obj.magic a0)
  let get_iform_enum (a0 : [>`Read] t) : XedBindingsEnums.iform =
    Bindings.xed_decoded_inst_get_iform_enum (Obj.magic a0)
  let get_iform_enum_dispatch (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_iform_enum_dispatch (Obj.magic a0)
  let get_immediate_is_signed (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_immediate_is_signed (Obj.magic a0)
  let get_immediate_width (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_immediate_width (Obj.magic a0)
  let get_immediate_width_bits (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_immediate_width_bits (Obj.magic a0)
  let get_index_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_index_reg (Obj.magic a0) a1
  let get_input_chip (a0 : [>`Read] t) : XedBindingsEnums.chip =
    Bindings.xed_decoded_inst_get_input_chip (Obj.magic a0)
  let get_isa_set (a0 : [>`Read] t) : XedBindingsEnums.isa_set =
    Bindings.xed_decoded_inst_get_isa_set (Obj.magic a0)
  let get_length (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_length (Obj.magic a0)
  let get_machine_mode_bits (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_machine_mode_bits (Obj.magic a0)
  let get_memop_address_width (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_memop_address_width (Obj.magic a0) a1
  let get_memory_displacement (a0 : [>`Read] t) (a1 : int) : Signed.Int64.t =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_memory_displacement (Obj.magic a0) a1
  let get_memory_displacement_width (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_memory_displacement_width (Obj.magic a0) a1
  let get_memory_displacement_width_bits (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_memory_displacement_width_bits (Obj.magic a0) a1
  let get_memory_operand_length (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_memory_operand_length (Obj.magic a0) a1
  let get_modrm (a0 : [>`Read] t) : char =
    Bindings.xed_decoded_inst_get_modrm (Obj.magic a0)
  let get_nprefixes (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_nprefixes (Obj.magic a0)
  let get_operand_width (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_decoded_inst_get_operand_width (Obj.magic a0)
  let get_reg (a0 : [>`Read] t) (a1 : XedBindingsEnums.operand) : XedBindingsEnums.reg =
    Bindings.xed_decoded_inst_get_reg (Obj.magic a0) a1
  let get_rflags_info (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.SimpleFlag.t =
    Bindings.xed_decoded_inst_get_rflags_info (Obj.magic a0)
  let get_scale (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_scale (Obj.magic a0) a1
  let get_second_immediate (a0 : [>`Read] t) : char =
    Bindings.xed_decoded_inst_get_second_immediate (Obj.magic a0)
  let get_seg_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_get_seg_reg (Obj.magic a0) a1
  let get_signed_immediate (a0 : [>`Read] t) : Signed.Int32.t =
    Bindings.xed_decoded_inst_get_signed_immediate (Obj.magic a0)
  let get_stack_address_mode_bits (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_get_stack_address_mode_bits (Obj.magic a0)
  let get_unsigned_immediate (a0 : [>`Read] t) : Unsigned.UInt64.t =
    Bindings.xed_decoded_inst_get_unsigned_immediate (Obj.magic a0)
  let get_user_data (a0 : [>`Read|`Write of [`Yes]] t) : Unsigned.UInt64.t =
    Bindings.xed_decoded_inst_get_user_data (Obj.magic a0)
  let has_mpx_prefix (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_decoded_inst_has_mpx_prefix (Obj.magic a0)
  let ild_decode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : string) : XedBindingsEnums.error =
    Bindings.xed_ild_decode (Obj.magic a0) (Ctypes.ocaml_string_start a1) (String.length a1)
  let inst (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.Inst.t =
    Bindings.xed_decoded_inst_inst (Obj.magic a0)
  let is_broadcast (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_is_broadcast (Obj.magic a0)
  let is_broadcast_instruction (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_is_broadcast_instruction (Obj.magic a0)
  let is_prefetch (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_is_prefetch (Obj.magic a0)
  let is_xacquire (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_decoded_inst_is_xacquire (Obj.magic a0)
  let is_xrelease (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_decoded_inst_is_xrelease (Obj.magic a0)
  let masked_vector_operation (a0 : [>`Read|`Write of [`Yes]] t) : bool =
    Bindings.xed_decoded_inst_masked_vector_operation (Obj.magic a0)
  let masking (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_masking (Obj.magic a0)
  let mem_read (a0 : [>`Read] t) (a1 : int) : bool =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_mem_read (Obj.magic a0) a1
  let mem_written (a0 : [>`Read] t) (a1 : int) : bool =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_mem_written (Obj.magic a0) a1
  let mem_written_only (a0 : [>`Read] t) (a1 : int) : bool =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_mem_written_only (Obj.magic a0) a1
  let merging (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_merging (Obj.magic a0)
  let noperands (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_noperands (Obj.magic a0)
  let number_of_memory_operands (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_number_of_memory_operands (Obj.magic a0)
  let operand_action (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.operand_action =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_action (Obj.magic a0) a1
  let operand_element_size_bits (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_element_size_bits (Obj.magic a0) a1
  let operand_element_type (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.operand_element_type =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_element_type (Obj.magic a0) a1
  let operand_elements (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_elements (Obj.magic a0) a1
  let operand_length (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_length (Obj.magic a0) a1
  let operand_length_bits (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_operand_length_bits (Obj.magic a0) a1
  let operands (a0 : [>`Read|`Write of [`Yes]] t) : [<`Read|`Write of [`Yes]] XedBindingsStructs.OperandValues.t =
    Bindings.xed_decoded_inst_operands (Obj.magic a0)
  let operands_const (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.OperandValues.t =
    Bindings.xed_decoded_inst_operands_const (Obj.magic a0)
  let set_branch_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_branch_displacement (Obj.magic a0) a1 a2
  let set_branch_displacement_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_branch_displacement_bits (Obj.magic a0) a1 a2
  let set_immediate_signed (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_immediate_signed (Obj.magic a0) a1 a2
  let set_immediate_signed_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_immediate_signed_bits (Obj.magic a0) a1 a2
  let set_immediate_unsigned (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_immediate_unsigned (Obj.magic a0) a1 a2
  let set_immediate_unsigned_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_immediate_unsigned_bits (Obj.magic a0) a1 a2
  let set_input_chip (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.chip) : unit =
    Bindings.xed_decoded_inst_set_input_chip (Obj.magic a0) a1
  let set_memory_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_memory_displacement (Obj.magic a0) a1 a2
  let set_memory_displacement_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_decoded_inst_set_memory_displacement_bits (Obj.magic a0) a1 a2
  let set_mode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.machine_mode) (a2 : XedBindingsEnums.address_width) : unit =
    Bindings.xed_decoded_inst_set_mode (Obj.magic a0) a1 a2
  let set_scale (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_decoded_inst_set_scale (Obj.magic a0) a1
  let set_user_data (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) : unit =
    Bindings.xed_decoded_inst_set_user_data (Obj.magic a0) a1
  let uses_embedded_broadcast (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_uses_embedded_broadcast (Obj.magic a0)
  let uses_rflags (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_uses_rflags (Obj.magic a0)
  let valid (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_valid (Obj.magic a0)
  let valid_for_chip (a0 : [>`Read] t) (a1 : XedBindingsEnums.chip) : bool =
    Bindings.xed_decoded_inst_valid_for_chip (Obj.magic a0) a1
  let vector_length_bits (a0 : [>`Read] t) : int =
    Bindings.xed_decoded_inst_vector_length_bits (Obj.magic a0)
  let zero (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_decoded_inst_zero (Obj.magic a0)
  let zero_keep_mode (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_decoded_inst_zero_keep_mode (Obj.magic a0)
  let zero_keep_mode_from_operands (a0 : [>`Read|`Write of [`Yes]] t) (a1 : [>`Read] XedBindingsStructs.OperandValues.t) : unit =
    Bindings.xed_decoded_inst_zero_keep_mode_from_operands (Obj.magic a0) (Obj.magic a1)
  let zero_set_mode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : [>`Read] XedBindingsStructs.State.t) : unit =
    Bindings.xed_decoded_inst_zero_set_mode (Obj.magic a0) (Obj.magic a1)
  let zeroing (a0 : [>`Read] t) : bool =
    Bindings.xed_decoded_inst_zeroing (Obj.magic a0)
end

module EncoderInstruction = struct
  include XedBindingsStructs.EncoderInstruction
  let addr (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_addr (Obj.magic a0) a1
  let rep (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_rep (Obj.magic a0)
  let repne (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_repne (Obj.magic a0)
end

module EncoderRequest = struct
  include XedBindingsStructs.EncoderRequest
  let convert_to_encoder_request (a0 : [>`Read|`Write of [`Yes]] t) (a1 : [>`Read|`Write of [`Yes]] XedBindingsStructs.EncoderInstruction.t) : bool =
    Bindings.xed_convert_to_encoder_request (Obj.magic a0) (Obj.magic a1)
  let get_iclass (a0 : [>`Read] t) : XedBindingsEnums.iclass =
    Bindings.xed_encoder_request_get_iclass (Obj.magic a0)
  let get_operand_order (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : XedBindingsEnums.operand =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_get_operand_order (Obj.magic a0) a1
  let operand_order_entries (a0 : [>`Read|`Write of [`Yes]] t) : int =
    Bindings.xed_encoder_request_operand_order_entries (Obj.magic a0)
  let operands (a0 : [>`Read|`Write of [`Yes]] t) : [<`Read|`Write of [`Yes]] XedBindingsStructs.OperandValues.t =
    Bindings.xed_encoder_request_operands (Obj.magic a0)
  let operands_const (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.OperandValues.t =
    Bindings.xed_encoder_request_operands_const (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : unit =
    Bindings.xed_encode_request_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let set_agen (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_set_agen (Obj.magic a0)
  let set_base0 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_base0 (Obj.magic a0) a1
  let set_base1 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_base1 (Obj.magic a0) a1
  let set_branch_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_encoder_request_set_branch_displacement (Obj.magic a0) a1 a2
  let set_effective_address_size (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_set_effective_address_size (Obj.magic a0) a1
  let set_effective_operand_width (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_set_effective_operand_width (Obj.magic a0) a1
  let set_iclass (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.iclass) : unit =
    Bindings.xed_encoder_request_set_iclass (Obj.magic a0) a1
  let set_index (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_index (Obj.magic a0) a1
  let set_mem0 (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_set_mem0 (Obj.magic a0)
  let set_mem1 (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_set_mem1 (Obj.magic a0)
  let set_memory_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_encoder_request_set_memory_displacement (Obj.magic a0) a1 a2
  let set_memory_operand_length (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_set_memory_operand_length (Obj.magic a0) a1
  let set_operand_order (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) (a2 : XedBindingsEnums.operand) : unit =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_set_operand_order (Obj.magic a0) a1 a2
  let set_ptr (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_set_ptr (Obj.magic a0)
  let set_reg (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.operand) (a2 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_reg (Obj.magic a0) a1 a2
  let set_relbr (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_set_relbr (Obj.magic a0)
  let set_scale (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_encoder_request_set_scale (Obj.magic a0) a1
  let set_seg0 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_seg0 (Obj.magic a0) a1
  let set_seg1 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed_encoder_request_set_seg1 (Obj.magic a0) a1
  let set_simm (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_encoder_request_set_simm (Obj.magic a0) a1 a2
  let set_uimm0 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_encoder_request_set_uimm0 (Obj.magic a0) a1 a2
  let set_uimm0_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_encoder_request_set_uimm0_bits (Obj.magic a0) a1 a2
  let set_uimm1 (a0 : [>`Read|`Write of [`Yes]] t) (a1 : char) : unit =
    Bindings.xed_encoder_request_set_uimm1 (Obj.magic a0) a1
  let zero (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_zero (Obj.magic a0)
  let zero_operand_order (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_encoder_request_zero_operand_order (Obj.magic a0)
  let zero_set_mode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : [>`Read] XedBindingsStructs.State.t) : unit =
    Bindings.xed_encoder_request_zero_set_mode (Obj.magic a0) (Obj.magic a1)
end

module FlagAction = struct
  include XedBindingsStructs.FlagAction
  let get_action (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.flag_action =
    assert (a1 >= 0);
    Bindings.xed_flag_action_get_action (Obj.magic a0) a1
  let get_flag_name (a0 : [>`Read] t) : XedBindingsEnums.flag =
    Bindings.xed_flag_action_get_flag_name (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : int =
    Bindings.xed_flag_action_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let read_flag (a0 : [>`Read] t) : bool =
    Bindings.xed_flag_action_read_flag (Obj.magic a0)
  let writes_flag (a0 : [>`Read] t) : bool =
    Bindings.xed_flag_action_writes_flag (Obj.magic a0)
end

module FlagSet = struct
  include XedBindingsStructs.FlagSet
  let is_subset_of (a0 : [>`Read] t) (a1 : [>`Read] t) : bool =
    Bindings.xed_flag_set_is_subset_of (Obj.magic a0) (Obj.magic a1)
  let mask (a0 : [>`Read] t) : int =
    Bindings.xed_flag_set_mask (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : int =
    Bindings.xed_flag_set_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
end

module Inst = struct
  include XedBindingsStructs.Inst
  let category (a0 : [>`Read] t) : XedBindingsEnums.category =
    Bindings.xed_inst_category (Obj.magic a0)
  let cpl (a0 : [>`Read] t) : int =
    Bindings.xed_inst_cpl (Obj.magic a0)
  let extension (a0 : [>`Read] t) : XedBindingsEnums.extension =
    Bindings.xed_inst_extension (Obj.magic a0)
  let flag_info_index (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_inst_flag_info_index (Obj.magic a0)
  let get_attribute (a0 : [>`Read] t) (a1 : XedBindingsEnums.attribute) : Unsigned.UInt32.t =
    Bindings.xed_inst_get_attribute (Obj.magic a0) a1
  let iclass (a0 : [>`Read] t) : XedBindingsEnums.iclass =
    Bindings.xed_inst_iclass (Obj.magic a0)
  let iexception (a0 : [>`Read] t) : XedBindingsEnums.iexception =
    Bindings.xed_inst_exception (Obj.magic a0)
  let iform_enum (a0 : [>`Read] t) : XedBindingsEnums.iform =
    Bindings.xed_inst_iform_enum (Obj.magic a0)
  let isa_set (a0 : [>`Read] t) : XedBindingsEnums.isa_set =
    Bindings.xed_inst_isa_set (Obj.magic a0)
  let noperands (a0 : [>`Read] t) : int =
    Bindings.xed_inst_noperands (Obj.magic a0)
  let operand (a0 : [>`Read] t) (a1 : int) : [<`Read|`Write of [`No]] XedBindingsStructs.Operand.t =
    assert (a1 >= 0);
    Bindings.xed_inst_operand (Obj.magic a0) a1
end

module Operand = struct
  include XedBindingsStructs.Operand
  let conditional_read (a0 : [>`Read] t) : int =
    Bindings.xed_operand_conditional_read (Obj.magic a0)
  let conditional_write (a0 : [>`Read] t) : int =
    Bindings.xed_operand_conditional_write (Obj.magic a0)
  let imm (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_imm (Obj.magic a0)
  let name (a0 : [>`Read] t) : XedBindingsEnums.operand =
    Bindings.xed_operand_name (Obj.magic a0)
  let nonterminal_name (a0 : [>`Read] t) : XedBindingsEnums.nonterminal =
    Bindings.xed_operand_nonterminal_name (Obj.magic a0)
  let op_type (a0 : [>`Read] t) : XedBindingsEnums.operand_type =
    Bindings.xed_operand_type (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : unit =
    Bindings.xed_operand_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let read (a0 : [>`Read] t) : int =
    Bindings.xed_operand_read (Obj.magic a0)
  let read_and_written (a0 : [>`Read] t) : int =
    Bindings.xed_operand_read_and_written (Obj.magic a0)
  let read_only (a0 : [>`Read] t) : int =
    Bindings.xed_operand_read_only (Obj.magic a0)
  let reg (a0 : [>`Read] t) : XedBindingsEnums.reg =
    Bindings.xed_operand_reg (Obj.magic a0)
  let rw (a0 : [>`Read] t) : XedBindingsEnums.operand_action =
    Bindings.xed_operand_rw (Obj.magic a0)
  let template_is_register (a0 : [>`Read] t) : int =
    Bindings.xed_operand_template_is_register (Obj.magic a0)
  let visibility (a0 : [>`Read] t) : XedBindingsEnums.operand_visibility =
    Bindings.xed_operand_operand_visibility (Obj.magic a0)
  let width (a0 : [>`Read] t) : XedBindingsEnums.operand_width =
    Bindings.xed_operand_width (Obj.magic a0)
  let width_bits (a0 : [>`Read] t) (a1 : Unsigned.UInt32.t) : Unsigned.UInt32.t =
    Bindings.xed_operand_width_bits (Obj.magic a0) a1
  let written (a0 : [>`Read] t) : int =
    Bindings.xed_operand_written (Obj.magic a0)
  let written_only (a0 : [>`Read] t) : int =
    Bindings.xed_operand_written_only (Obj.magic a0)
  let xtype (a0 : [>`Read] t) : XedBindingsEnums.operand_element_xtype =
    Bindings.xed_operand_xtype (Obj.magic a0)
end

module Operand3 = struct
  let get_agen (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_agen (Obj.magic a0)
  let get_amd3dnow (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_amd3dnow (Obj.magic a0)
  let get_asz (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_asz (Obj.magic a0)
  let get_base0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_base0 (Obj.magic a0)
  let get_base1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_base1 (Obj.magic a0)
  let get_bcast (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_bcast (Obj.magic a0)
  let get_bcrc (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_bcrc (Obj.magic a0)
  let get_brdisp_width (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : char =
    Bindings.xed3_operand_get_brdisp_width (Obj.magic a0)
  let get_cet (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_cet (Obj.magic a0)
  let get_chip (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.chip =
    Bindings.xed3_operand_get_chip (Obj.magic a0)
  let get_cldemote (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_cldemote (Obj.magic a0)
  let get_default_seg (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_default_seg (Obj.magic a0)
  let get_df32 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_df32 (Obj.magic a0)
  let get_df64 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_df64 (Obj.magic a0)
  let get_disp (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : Signed.Int64.t =
    Bindings.xed3_operand_get_disp (Obj.magic a0)
  let get_disp_width (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : char =
    Bindings.xed3_operand_get_disp_width (Obj.magic a0)
  let get_dummy (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_dummy (Obj.magic a0)
  let get_easz (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_easz (Obj.magic a0)
  let get_element_size (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_element_size (Obj.magic a0)
  let get_encode_force (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_encode_force (Obj.magic a0)
  let get_encoder_preferred (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_encoder_preferred (Obj.magic a0)
  let get_eosz (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_eosz (Obj.magic a0)
  let get_error (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.error =
    Bindings.xed3_operand_get_error (Obj.magic a0)
  let get_esrc (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_esrc (Obj.magic a0)
  let get_first_f2f3 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_first_f2f3 (Obj.magic a0)
  let get_has_modrm (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_has_modrm (Obj.magic a0)
  let get_has_sib (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_has_sib (Obj.magic a0)
  let get_hint (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_hint (Obj.magic a0)
  let get_iclass (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.iclass =
    Bindings.xed3_operand_get_iclass (Obj.magic a0)
  let get_ild_f2 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_ild_f2 (Obj.magic a0)
  let get_ild_f3 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_ild_f3 (Obj.magic a0)
  let get_ild_seg (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_ild_seg (Obj.magic a0)
  let get_imm0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_imm0 (Obj.magic a0)
  let get_imm0signed (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_imm0signed (Obj.magic a0)
  let get_imm1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_imm1 (Obj.magic a0)
  let get_imm1_bytes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_imm1_bytes (Obj.magic a0)
  let get_imm_width (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : char =
    Bindings.xed3_operand_get_imm_width (Obj.magic a0)
  let get_index (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_index (Obj.magic a0)
  let get_last_f2f3 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_last_f2f3 (Obj.magic a0)
  let get_llrc (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_llrc (Obj.magic a0)
  let get_lock (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_lock (Obj.magic a0)
  let get_lzcnt (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_lzcnt (Obj.magic a0)
  let get_map (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_map (Obj.magic a0)
  let get_mask (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mask (Obj.magic a0)
  let get_max_bytes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_max_bytes (Obj.magic a0)
  let get_mem0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mem0 (Obj.magic a0)
  let get_mem1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mem1 (Obj.magic a0)
  let get_mem_width (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : Unsigned.UInt16.t =
    Bindings.xed3_operand_get_mem_width (Obj.magic a0)
  let get_mod (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mod (Obj.magic a0)
  let get_mode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mode (Obj.magic a0)
  let get_mode_first_prefix (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mode_first_prefix (Obj.magic a0)
  let get_mode_short_ud0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mode_short_ud0 (Obj.magic a0)
  let get_modep5 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_modep5 (Obj.magic a0)
  let get_modep55c (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_modep55c (Obj.magic a0)
  let get_modrm_byte (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_modrm_byte (Obj.magic a0)
  let get_mpxmode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_mpxmode (Obj.magic a0)
  let get_must_use_evex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_must_use_evex (Obj.magic a0)
  let get_need_memdisp (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_need_memdisp (Obj.magic a0)
  let get_need_sib (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_need_sib (Obj.magic a0)
  let get_needrex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_needrex (Obj.magic a0)
  let get_nelem (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_nelem (Obj.magic a0)
  let get_no_evex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_no_evex (Obj.magic a0)
  let get_no_vex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_no_vex (Obj.magic a0)
  let get_nominal_opcode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_nominal_opcode (Obj.magic a0)
  let get_norex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_norex (Obj.magic a0)
  let get_nprefixes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_nprefixes (Obj.magic a0)
  let get_nrexes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_nrexes (Obj.magic a0)
  let get_nseg_prefixes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_nseg_prefixes (Obj.magic a0)
  let get_osz (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_osz (Obj.magic a0)
  let get_out_of_bytes (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_out_of_bytes (Obj.magic a0)
  let get_outreg (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_outreg (Obj.magic a0)
  let get_p4 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_p4 (Obj.magic a0)
  let get_pos_disp (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_disp (Obj.magic a0)
  let get_pos_imm (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_imm (Obj.magic a0)
  let get_pos_imm1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_imm1 (Obj.magic a0)
  let get_pos_modrm (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_modrm (Obj.magic a0)
  let get_pos_nominal_opcode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_nominal_opcode (Obj.magic a0)
  let get_pos_sib (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_pos_sib (Obj.magic a0)
  let get_prefix66 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_prefix66 (Obj.magic a0)
  let get_ptr (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_ptr (Obj.magic a0)
  let get_realmode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_realmode (Obj.magic a0)
  let get_reg (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_reg (Obj.magic a0)
  let get_reg0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg0 (Obj.magic a0)
  let get_reg1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg1 (Obj.magic a0)
  let get_reg2 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg2 (Obj.magic a0)
  let get_reg3 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg3 (Obj.magic a0)
  let get_reg4 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg4 (Obj.magic a0)
  let get_reg5 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg5 (Obj.magic a0)
  let get_reg6 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg6 (Obj.magic a0)
  let get_reg7 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg7 (Obj.magic a0)
  let get_reg8 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg8 (Obj.magic a0)
  let get_reg9 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_reg9 (Obj.magic a0)
  let get_relbr (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_relbr (Obj.magic a0)
  let get_rep (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rep (Obj.magic a0)
  let get_rex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rex (Obj.magic a0)
  let get_rexb (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rexb (Obj.magic a0)
  let get_rexr (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rexr (Obj.magic a0)
  let get_rexrr (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rexrr (Obj.magic a0)
  let get_rexw (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rexw (Obj.magic a0)
  let get_rexx (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rexx (Obj.magic a0)
  let get_rm (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_rm (Obj.magic a0)
  let get_roundc (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_roundc (Obj.magic a0)
  let get_sae (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_sae (Obj.magic a0)
  let get_scale (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_scale (Obj.magic a0)
  let get_seg0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_seg0 (Obj.magic a0)
  let get_seg1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : XedBindingsEnums.reg =
    Bindings.xed3_operand_get_seg1 (Obj.magic a0)
  let get_seg_ovd (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_seg_ovd (Obj.magic a0)
  let get_sibbase (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_sibbase (Obj.magic a0)
  let get_sibindex (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_sibindex (Obj.magic a0)
  let get_sibscale (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_sibscale (Obj.magic a0)
  let get_smode (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_smode (Obj.magic a0)
  let get_srm (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_srm (Obj.magic a0)
  let get_tzcnt (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_tzcnt (Obj.magic a0)
  let get_ubit (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_ubit (Obj.magic a0)
  let get_uimm0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : Unsigned.UInt64.t =
    Bindings.xed3_operand_get_uimm0 (Obj.magic a0)
  let get_uimm1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : char =
    Bindings.xed3_operand_get_uimm1 (Obj.magic a0)
  let get_using_default_segment0 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_using_default_segment0 (Obj.magic a0)
  let get_using_default_segment1 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_using_default_segment1 (Obj.magic a0)
  let get_vex_c4 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vex_c4 (Obj.magic a0)
  let get_vex_prefix (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vex_prefix (Obj.magic a0)
  let get_vexdest210 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vexdest210 (Obj.magic a0)
  let get_vexdest3 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vexdest3 (Obj.magic a0)
  let get_vexdest4 (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vexdest4 (Obj.magic a0)
  let get_vexvalid (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vexvalid (Obj.magic a0)
  let get_vl (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_vl (Obj.magic a0)
  let get_wbnoinvd (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_wbnoinvd (Obj.magic a0)
  let get_zeroing (a0 : [>`Read] XedBindingsStructs.DecodedInst.t) : int =
    Bindings.xed3_operand_get_zeroing (Obj.magic a0)
  let set_agen (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_agen (Obj.magic a0) a1
  let set_amd3dnow (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_amd3dnow (Obj.magic a0) a1
  let set_asz (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_asz (Obj.magic a0) a1
  let set_base0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_base0 (Obj.magic a0) a1
  let set_base1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_base1 (Obj.magic a0) a1
  let set_bcast (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_bcast (Obj.magic a0) a1
  let set_bcrc (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_bcrc (Obj.magic a0) a1
  let set_brdisp_width (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : char) : unit =
    Bindings.xed3_operand_set_brdisp_width (Obj.magic a0) a1
  let set_cet (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_cet (Obj.magic a0) a1
  let set_chip (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.chip) : unit =
    Bindings.xed3_operand_set_chip (Obj.magic a0) a1
  let set_cldemote (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_cldemote (Obj.magic a0) a1
  let set_default_seg (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_default_seg (Obj.magic a0) a1
  let set_df32 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_df32 (Obj.magic a0) a1
  let set_df64 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_df64 (Obj.magic a0) a1
  let set_disp (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : Signed.Int64.t) : unit =
    Bindings.xed3_operand_set_disp (Obj.magic a0) a1
  let set_disp_width (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : char) : unit =
    Bindings.xed3_operand_set_disp_width (Obj.magic a0) a1
  let set_dummy (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_dummy (Obj.magic a0) a1
  let set_easz (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_easz (Obj.magic a0) a1
  let set_element_size (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_element_size (Obj.magic a0) a1
  let set_encode_force (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_encode_force (Obj.magic a0) a1
  let set_encoder_preferred (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_encoder_preferred (Obj.magic a0) a1
  let set_eosz (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_eosz (Obj.magic a0) a1
  let set_error (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.error) : unit =
    Bindings.xed3_operand_set_error (Obj.magic a0) a1
  let set_esrc (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_esrc (Obj.magic a0) a1
  let set_first_f2f3 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_first_f2f3 (Obj.magic a0) a1
  let set_has_modrm (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_has_modrm (Obj.magic a0) a1
  let set_has_sib (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_has_sib (Obj.magic a0) a1
  let set_hint (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_hint (Obj.magic a0) a1
  let set_iclass (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.iclass) : unit =
    Bindings.xed3_operand_set_iclass (Obj.magic a0) a1
  let set_ild_f2 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_ild_f2 (Obj.magic a0) a1
  let set_ild_f3 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_ild_f3 (Obj.magic a0) a1
  let set_ild_seg (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_ild_seg (Obj.magic a0) a1
  let set_imm0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_imm0 (Obj.magic a0) a1
  let set_imm0signed (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_imm0signed (Obj.magic a0) a1
  let set_imm1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_imm1 (Obj.magic a0) a1
  let set_imm1_bytes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_imm1_bytes (Obj.magic a0) a1
  let set_imm_width (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : char) : unit =
    Bindings.xed3_operand_set_imm_width (Obj.magic a0) a1
  let set_index (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_index (Obj.magic a0) a1
  let set_last_f2f3 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_last_f2f3 (Obj.magic a0) a1
  let set_llrc (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_llrc (Obj.magic a0) a1
  let set_lock (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_lock (Obj.magic a0) a1
  let set_lzcnt (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_lzcnt (Obj.magic a0) a1
  let set_map (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_map (Obj.magic a0) a1
  let set_mask (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mask (Obj.magic a0) a1
  let set_max_bytes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_max_bytes (Obj.magic a0) a1
  let set_mem0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mem0 (Obj.magic a0) a1
  let set_mem1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mem1 (Obj.magic a0) a1
  let set_mem_width (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : Unsigned.UInt16.t) : unit =
    Bindings.xed3_operand_set_mem_width (Obj.magic a0) a1
  let set_mod (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mod (Obj.magic a0) a1
  let set_mode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mode (Obj.magic a0) a1
  let set_mode_first_prefix (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mode_first_prefix (Obj.magic a0) a1
  let set_mode_short_ud0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mode_short_ud0 (Obj.magic a0) a1
  let set_modep5 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_modep5 (Obj.magic a0) a1
  let set_modep55c (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_modep55c (Obj.magic a0) a1
  let set_modrm_byte (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_modrm_byte (Obj.magic a0) a1
  let set_mpxmode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_mpxmode (Obj.magic a0) a1
  let set_must_use_evex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_must_use_evex (Obj.magic a0) a1
  let set_need_memdisp (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_need_memdisp (Obj.magic a0) a1
  let set_need_sib (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_need_sib (Obj.magic a0) a1
  let set_needrex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_needrex (Obj.magic a0) a1
  let set_nelem (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_nelem (Obj.magic a0) a1
  let set_no_evex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_no_evex (Obj.magic a0) a1
  let set_no_vex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_no_vex (Obj.magic a0) a1
  let set_nominal_opcode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_nominal_opcode (Obj.magic a0) a1
  let set_norex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_norex (Obj.magic a0) a1
  let set_nprefixes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_nprefixes (Obj.magic a0) a1
  let set_nrexes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_nrexes (Obj.magic a0) a1
  let set_nseg_prefixes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_nseg_prefixes (Obj.magic a0) a1
  let set_osz (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_osz (Obj.magic a0) a1
  let set_out_of_bytes (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_out_of_bytes (Obj.magic a0) a1
  let set_outreg (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_outreg (Obj.magic a0) a1
  let set_p4 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_p4 (Obj.magic a0) a1
  let set_pos_disp (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_disp (Obj.magic a0) a1
  let set_pos_imm (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_imm (Obj.magic a0) a1
  let set_pos_imm1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_imm1 (Obj.magic a0) a1
  let set_pos_modrm (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_modrm (Obj.magic a0) a1
  let set_pos_nominal_opcode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_nominal_opcode (Obj.magic a0) a1
  let set_pos_sib (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_pos_sib (Obj.magic a0) a1
  let set_prefix66 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_prefix66 (Obj.magic a0) a1
  let set_ptr (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_ptr (Obj.magic a0) a1
  let set_realmode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_realmode (Obj.magic a0) a1
  let set_reg (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_reg (Obj.magic a0) a1
  let set_reg0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg0 (Obj.magic a0) a1
  let set_reg1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg1 (Obj.magic a0) a1
  let set_reg2 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg2 (Obj.magic a0) a1
  let set_reg3 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg3 (Obj.magic a0) a1
  let set_reg4 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg4 (Obj.magic a0) a1
  let set_reg5 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg5 (Obj.magic a0) a1
  let set_reg6 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg6 (Obj.magic a0) a1
  let set_reg7 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg7 (Obj.magic a0) a1
  let set_reg8 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg8 (Obj.magic a0) a1
  let set_reg9 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_reg9 (Obj.magic a0) a1
  let set_relbr (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_relbr (Obj.magic a0) a1
  let set_rep (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rep (Obj.magic a0) a1
  let set_rex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rex (Obj.magic a0) a1
  let set_rexb (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rexb (Obj.magic a0) a1
  let set_rexr (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rexr (Obj.magic a0) a1
  let set_rexrr (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rexrr (Obj.magic a0) a1
  let set_rexw (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rexw (Obj.magic a0) a1
  let set_rexx (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rexx (Obj.magic a0) a1
  let set_rm (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_rm (Obj.magic a0) a1
  let set_roundc (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_roundc (Obj.magic a0) a1
  let set_sae (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_sae (Obj.magic a0) a1
  let set_scale (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_scale (Obj.magic a0) a1
  let set_seg0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_seg0 (Obj.magic a0) a1
  let set_seg1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : XedBindingsEnums.reg) : unit =
    Bindings.xed3_operand_set_seg1 (Obj.magic a0) a1
  let set_seg_ovd (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_seg_ovd (Obj.magic a0) a1
  let set_sibbase (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_sibbase (Obj.magic a0) a1
  let set_sibindex (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_sibindex (Obj.magic a0) a1
  let set_sibscale (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_sibscale (Obj.magic a0) a1
  let set_smode (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_smode (Obj.magic a0) a1
  let set_srm (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_srm (Obj.magic a0) a1
  let set_tzcnt (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_tzcnt (Obj.magic a0) a1
  let set_ubit (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_ubit (Obj.magic a0) a1
  let set_uimm0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : Unsigned.UInt64.t) : unit =
    Bindings.xed3_operand_set_uimm0 (Obj.magic a0) a1
  let set_uimm1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : char) : unit =
    Bindings.xed3_operand_set_uimm1 (Obj.magic a0) a1
  let set_using_default_segment0 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_using_default_segment0 (Obj.magic a0) a1
  let set_using_default_segment1 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_using_default_segment1 (Obj.magic a0) a1
  let set_vex_c4 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vex_c4 (Obj.magic a0) a1
  let set_vex_prefix (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vex_prefix (Obj.magic a0) a1
  let set_vexdest210 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vexdest210 (Obj.magic a0) a1
  let set_vexdest3 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vexdest3 (Obj.magic a0) a1
  let set_vexdest4 (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vexdest4 (Obj.magic a0) a1
  let set_vexvalid (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vexvalid (Obj.magic a0) a1
  let set_vl (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_vl (Obj.magic a0) a1
  let set_wbnoinvd (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_wbnoinvd (Obj.magic a0) a1
  let set_zeroing (a0 : [>`Read|`Write of [`Yes]] XedBindingsStructs.DecodedInst.t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed3_operand_set_zeroing (Obj.magic a0) a1
end

module OperandValues = struct
  include XedBindingsStructs.OperandValues
  let accesses_memory (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_accesses_memory (Obj.magic a0)
  let branch_not_taken_hint (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_branch_not_taken_hint (Obj.magic a0)
  let branch_taken_hint (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_branch_taken_hint (Obj.magic a0)
  let cet_no_track (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_cet_no_track (Obj.magic a0)
  let clear_rep (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_clear_rep (Obj.magic a0)
  let dump (a0 : [>`Read] t) (a1 : bytes) : unit =
    Bindings.xed_operand_values_dump (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let get_atomic (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_get_atomic (Obj.magic a0)
  let get_base_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_base_reg (Obj.magic a0) a1
  let get_branch_displacement_byte (a0 : [>`Read] t) (a1 : int) : char =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_branch_displacement_byte (Obj.magic a0) a1
  let get_branch_displacement_int32 (a0 : [>`Read] t) : Signed.Int32.t =
    Bindings.xed_operand_values_get_branch_displacement_int32 (Obj.magic a0)
  let get_branch_displacement_length (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_branch_displacement_length (Obj.magic a0)
  let get_branch_displacement_length_bits (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_branch_displacement_length_bits (Obj.magic a0)
  let get_displacement_for_memop (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_get_displacement_for_memop (Obj.magic a0)
  let get_effective_address_width (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_effective_address_width (Obj.magic a0)
  let get_effective_operand_width (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_effective_operand_width (Obj.magic a0)
  let get_iclass (a0 : [>`Read] t) : XedBindingsEnums.iclass =
    Bindings.xed_operand_values_get_iclass (Obj.magic a0)
  let get_immediate_byte (a0 : [>`Read] t) (a1 : int) : char =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_immediate_byte (Obj.magic a0) a1
  let get_immediate_int64 (a0 : [>`Read] t) : Signed.Int64.t =
    Bindings.xed_operand_values_get_immediate_int64 (Obj.magic a0)
  let get_immediate_is_signed (a0 : [>`Read] t) : int =
    Bindings.xed_operand_values_get_immediate_is_signed (Obj.magic a0)
  let get_immediate_uint64 (a0 : [>`Read] t) : Unsigned.UInt64.t =
    Bindings.xed_operand_values_get_immediate_uint64 (Obj.magic a0)
  let get_index_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_index_reg (Obj.magic a0) a1
  let get_long_mode (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_get_long_mode (Obj.magic a0)
  let get_memory_displacement_byte (a0 : [>`Read] t) (a1 : int) : char =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_memory_displacement_byte (Obj.magic a0) a1
  let get_memory_displacement_int64 (a0 : [>`Read] t) : Signed.Int64.t =
    Bindings.xed_operand_values_get_memory_displacement_int64 (Obj.magic a0)
  let get_memory_displacement_int64_raw (a0 : [>`Read] t) : Signed.Int64.t =
    Bindings.xed_operand_values_get_memory_displacement_int64_raw (Obj.magic a0)
  let get_memory_displacement_length (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_memory_displacement_length (Obj.magic a0)
  let get_memory_displacement_length_bits (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_memory_displacement_length_bits (Obj.magic a0)
  let get_memory_displacement_length_bits_raw (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_memory_displacement_length_bits_raw (Obj.magic a0)
  let get_memory_operand_length (a0 : [>`Read] t) (a1 : int) : int =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_memory_operand_length (Obj.magic a0) a1
  let get_real_mode (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_get_real_mode (Obj.magic a0)
  let get_scale (a0 : [>`Read] t) : int =
    Bindings.xed_operand_values_get_scale (Obj.magic a0)
  let get_second_immediate (a0 : [>`Read] t) : char =
    Bindings.xed_operand_values_get_second_immediate (Obj.magic a0)
  let get_seg_reg (a0 : [>`Read] t) (a1 : int) : XedBindingsEnums.reg =
    assert (a1 >= 0);
    Bindings.xed_operand_values_get_seg_reg (Obj.magic a0) a1
  let get_stack_address_width (a0 : [>`Read] t) : Unsigned.UInt32.t =
    Bindings.xed_operand_values_get_stack_address_width (Obj.magic a0)
  let has_66_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_66_prefix (Obj.magic a0)
  let has_address_size_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_address_size_prefix (Obj.magic a0)
  let has_branch_displacement (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_branch_displacement (Obj.magic a0)
  let has_displacement (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_displacement (Obj.magic a0)
  let has_immediate (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_immediate (Obj.magic a0)
  let has_lock_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_lock_prefix (Obj.magic a0)
  let has_memory_displacement (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_memory_displacement (Obj.magic a0)
  let has_modrm_byte (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_modrm_byte (Obj.magic a0)
  let has_operand_size_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_operand_size_prefix (Obj.magic a0)
  let has_real_rep (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_real_rep (Obj.magic a0)
  let has_rep_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_rep_prefix (Obj.magic a0)
  let has_repne_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_repne_prefix (Obj.magic a0)
  let has_rexw_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_rexw_prefix (Obj.magic a0)
  let has_segment_prefix (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_segment_prefix (Obj.magic a0)
  let has_sib_byte (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_has_sib_byte (Obj.magic a0)
  let init () : [<`Read|`Write of [`Yes]] t =
   let a0 = allocate () in
    Bindings.xed_operand_values_init (Obj.magic a0);
    a0
  let init_keep_mode (a1 : [>`Read] t) : [<`Read|`Write of [`Yes]] t =
   let a0 = allocate () in
    Bindings.xed_operand_values_init_keep_mode (Obj.magic a0) (Obj.magic a1);
    a0
  let init_set_mode (a1 : [>`Read] XedBindingsStructs.State.t) : [<`Read|`Write of [`Yes]] t =
   let a0 = allocate () in
    Bindings.xed_operand_values_init_set_mode (Obj.magic a0) (Obj.magic a1);
    a0
  let is_nop (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_is_nop (Obj.magic a0)
  let lockable (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_lockable (Obj.magic a0)
  let memop_without_modrm (a0 : [>`Read] t) : bool =
    Bindings.xed_operand_values_memop_without_modrm (Obj.magic a0)
  let number_of_memory_operands (a0 : [>`Read] t) : int =
    Bindings.xed_operand_values_number_of_memory_operands (Obj.magic a0)
  let print_short (a0 : [>`Read] t) (a1 : bytes) : unit =
    Bindings.xed_operand_values_print_short (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let segment_prefix (a0 : [>`Read] t) : XedBindingsEnums.reg =
    Bindings.xed_operand_values_segment_prefix (Obj.magic a0)
  let set_base_reg (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) (a2 : XedBindingsEnums.reg) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_base_reg (Obj.magic a0) a1 a2
  let set_branch_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_branch_displacement (Obj.magic a0) a1 a2
  let set_branch_displacement_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_branch_displacement_bits (Obj.magic a0) a1 a2
  let set_effective_address_width (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_effective_address_width (Obj.magic a0) a1
  let set_effective_operand_width (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_effective_operand_width (Obj.magic a0) a1
  let set_iclass (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.iclass) : unit =
    Bindings.xed_operand_values_set_iclass (Obj.magic a0) a1
  let set_immediate_signed (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_immediate_signed (Obj.magic a0) a1 a2
  let set_immediate_signed_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_immediate_signed_bits (Obj.magic a0) a1 a2
  let set_immediate_unsigned (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_immediate_unsigned (Obj.magic a0) a1 a2
  let set_immediate_unsigned_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_immediate_unsigned_bits (Obj.magic a0) a1 a2
  let set_index_reg (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) (a2 : XedBindingsEnums.reg) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_index_reg (Obj.magic a0) a1 a2
  let set_lock (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_set_lock (Obj.magic a0)
  let set_memory_displacement (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_memory_displacement (Obj.magic a0) a1 a2
  let set_memory_displacement_bits (a0 : [>`Read|`Write of [`Yes]] t) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Bindings.xed_operand_values_set_memory_displacement_bits (Obj.magic a0) a1 a2
  let set_memory_operand_length (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_memory_operand_length (Obj.magic a0) a1
  let set_mode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : [>`Read] XedBindingsStructs.State.t) : unit =
    Bindings.xed_operand_values_set_mode (Obj.magic a0) (Obj.magic a1)
  let set_operand_reg (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.operand) (a2 : XedBindingsEnums.reg) : unit =
    Bindings.xed_operand_values_set_operand_reg (Obj.magic a0) a1 a2
  let set_relbr (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_set_relbr (Obj.magic a0)
  let set_scale (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) (a2 : int) : unit =
    assert (a1 >= 0 && a2 >= 0);
    Bindings.xed_operand_values_set_scale (Obj.magic a0) a1 a2
  let set_seg_reg (a0 : [>`Read|`Write of [`Yes]] t) (a1 : int) (a2 : XedBindingsEnums.reg) : unit =
    assert (a1 >= 0);
    Bindings.xed_operand_values_set_seg_reg (Obj.magic a0) a1 a2
  let using_default_segment (a0 : [>`Read] t) (a1 : int) : bool =
    assert (a1 >= 0);
    Bindings.xed_operand_values_using_default_segment (Obj.magic a0) a1
  let zero_branch_displacement (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_zero_branch_displacement (Obj.magic a0)
  let zero_immediate (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_zero_immediate (Obj.magic a0)
  let zero_memory_displacement (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_zero_memory_displacement (Obj.magic a0)
  let zero_segment_override (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_operand_values_zero_segment_override (Obj.magic a0)
end

module SimpleFlag = struct
  include XedBindingsStructs.SimpleFlag
  let get_flag_action (a0 : [>`Read] t) (a1 : int) : [<`Read|`Write of [`No]] XedBindingsStructs.FlagAction.t =
    assert (a1 >= 0);
    Bindings.xed_simple_flag_get_flag_action (Obj.magic a0) a1
  let get_may_write (a0 : [>`Read] t) : bool =
    Bindings.xed_simple_flag_get_may_write (Obj.magic a0)
  let get_must_write (a0 : [>`Read] t) : bool =
    Bindings.xed_simple_flag_get_must_write (Obj.magic a0)
  let get_nflags (a0 : [>`Read] t) : int =
    Bindings.xed_simple_flag_get_nflags (Obj.magic a0)
  let get_read_flag_set (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.FlagSet.t =
    Bindings.xed_simple_flag_get_read_flag_set (Obj.magic a0)
  let get_undefined_flag_set (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.FlagSet.t =
    Bindings.xed_simple_flag_get_undefined_flag_set (Obj.magic a0)
  let get_written_flag_set (a0 : [>`Read] t) : [<`Read|`Write of [`No]] XedBindingsStructs.FlagSet.t =
    Bindings.xed_simple_flag_get_written_flag_set (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : int =
    Bindings.xed_simple_flag_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let reads_flags (a0 : [>`Read] t) : bool =
    Bindings.xed_simple_flag_reads_flags (Obj.magic a0)
  let writes_flags (a0 : [>`Read] t) : bool =
    Bindings.xed_simple_flag_writes_flags (Obj.magic a0)
end

module State = struct
  include XedBindingsStructs.State
  let get_address_width (a0 : [>`Read] t) : XedBindingsEnums.address_width =
    Bindings.xed_state_get_address_width (Obj.magic a0)
  let get_machine_mode (a0 : [>`Read] t) : XedBindingsEnums.machine_mode =
    Bindings.xed_state_get_machine_mode (Obj.magic a0)
  let get_stack_address_width (a0 : [>`Read] t) : XedBindingsEnums.address_width =
    Bindings.xed_state_get_stack_address_width (Obj.magic a0)
  let init (a1 : XedBindingsEnums.machine_mode) (a2 : XedBindingsEnums.address_width) (a3 : XedBindingsEnums.address_width) : [<`Read|`Write of [`Yes]] t =
   let a0 = allocate () in
    Bindings.xed_state_init (Obj.magic a0) a1 a2 a3;
    a0
  let init2 (a1 : XedBindingsEnums.machine_mode) (a2 : XedBindingsEnums.address_width) : [<`Read|`Write of [`Yes]] t =
   let a0 = allocate () in
    Bindings.xed_state_init2 (Obj.magic a0) a1 a2;
    a0
  let long64_mode (a0 : [>`Read] t) : bool =
    Bindings.xed_state_long64_mode (Obj.magic a0)
  let mode_width_16 (a0 : [>`Read] t) : bool =
    Bindings.xed_state_mode_width_16 (Obj.magic a0)
  let mode_width_32 (a0 : [>`Read] t) : bool =
    Bindings.xed_state_mode_width_32 (Obj.magic a0)
  let print (a0 : [>`Read] t) (a1 : bytes) : int =
    Bindings.xed_state_print (Obj.magic a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let real_mode (a0 : [>`Read] t) : bool =
    Bindings.xed_state_real_mode (Obj.magic a0)
  let set_machine_mode (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.machine_mode) : unit =
    Bindings.xed_state_set_machine_mode (Obj.magic a0) a1
  let set_stack_address_width (a0 : [>`Read|`Write of [`Yes]] t) (a1 : XedBindingsEnums.address_width) : unit =
    Bindings.xed_state_set_stack_address_width (Obj.magic a0) a1
  let zero (a0 : [>`Read|`Write of [`Yes]] t) : unit =
    Bindings.xed_state_zero (Obj.magic a0)
end


module Enum = struct
  include XedBindingsEnums
  let address_width_of_string (a0 : string) : XedBindingsEnums.address_width =
    Bindings.str2xed_address_width_enum_t a0
  let address_width_to_string (a0 : XedBindingsEnums.address_width) : string =
    Bindings.xed_address_width_enum_t2str a0
  let attribute_of_string (a0 : string) : XedBindingsEnums.attribute =
    Bindings.str2xed_attribute_enum_t a0
  let attribute_to_string (a0 : XedBindingsEnums.attribute) : string =
    Bindings.xed_attribute_enum_t2str a0
  let category_of_string (a0 : string) : XedBindingsEnums.category =
    Bindings.str2xed_category_enum_t a0
  let category_to_string (a0 : XedBindingsEnums.category) : string =
    Bindings.xed_category_enum_t2str a0
  let chip_of_string (a0 : string) : XedBindingsEnums.chip =
    Bindings.str2xed_chip_enum_t a0
  let chip_to_string (a0 : XedBindingsEnums.chip) : string =
    Bindings.xed_chip_enum_t2str a0
  let cpuid_bit_of_string (a0 : string) : XedBindingsEnums.cpuid_bit =
    Bindings.str2xed_cpuid_bit_enum_t a0
  let cpuid_bit_to_string (a0 : XedBindingsEnums.cpuid_bit) : string =
    Bindings.xed_cpuid_bit_enum_t2str a0
  let error_of_string (a0 : string) : XedBindingsEnums.error =
    Bindings.str2xed_error_enum_t a0
  let error_to_string (a0 : XedBindingsEnums.error) : string =
    Bindings.xed_error_enum_t2str a0
  let exception_of_string (a0 : string) : XedBindingsEnums.iexception =
    Bindings.str2xed_exception_enum_t a0
  let exception_to_string (a0 : XedBindingsEnums.iexception) : string =
    Bindings.xed_exception_enum_t2str a0
  let extension_of_string (a0 : string) : XedBindingsEnums.extension =
    Bindings.str2xed_extension_enum_t a0
  let extension_to_string (a0 : XedBindingsEnums.extension) : string =
    Bindings.xed_extension_enum_t2str a0
  let flag_action_of_string (a0 : string) : XedBindingsEnums.flag_action =
    Bindings.str2xed_flag_action_enum_t a0
  let flag_action_to_string (a0 : XedBindingsEnums.flag_action) : string =
    Bindings.xed_flag_action_enum_t2str a0
  let flag_of_string (a0 : string) : XedBindingsEnums.flag =
    Bindings.str2xed_flag_enum_t a0
  let flag_to_string (a0 : XedBindingsEnums.flag) : string =
    Bindings.xed_flag_enum_t2str a0
  let iclass_of_string (a0 : string) : XedBindingsEnums.iclass =
    Bindings.str2xed_iclass_enum_t a0
  let iclass_to_string (a0 : XedBindingsEnums.iclass) : string =
    Bindings.xed_iclass_enum_t2str a0
  let iform_of_string (a0 : string) : XedBindingsEnums.iform =
    Bindings.str2xed_iform_enum_t a0
  let iform_to_string (a0 : XedBindingsEnums.iform) : string =
    Bindings.xed_iform_enum_t2str a0
  let isa_set_of_string (a0 : string) : XedBindingsEnums.isa_set =
    Bindings.str2xed_isa_set_enum_t a0
  let isa_set_to_string (a0 : XedBindingsEnums.isa_set) : string =
    Bindings.xed_isa_set_enum_t2str a0
  let machine_mode_of_string (a0 : string) : XedBindingsEnums.machine_mode =
    Bindings.str2xed_machine_mode_enum_t a0
  let machine_mode_to_string (a0 : XedBindingsEnums.machine_mode) : string =
    Bindings.xed_machine_mode_enum_t2str a0
  let nonterminal_of_string (a0 : string) : XedBindingsEnums.nonterminal =
    Bindings.str2xed_nonterminal_enum_t a0
  let nonterminal_to_string (a0 : XedBindingsEnums.nonterminal) : string =
    Bindings.xed_nonterminal_enum_t2str a0
  let operand_action_of_string (a0 : string) : XedBindingsEnums.operand_action =
    Bindings.str2xed_operand_action_enum_t a0
  let operand_action_to_string (a0 : XedBindingsEnums.operand_action) : string =
    Bindings.xed_operand_action_enum_t2str a0
  let operand_convert_of_string (a0 : string) : XedBindingsEnums.operand_convert =
    Bindings.str2xed_operand_convert_enum_t a0
  let operand_convert_to_string (a0 : XedBindingsEnums.operand_convert) : string =
    Bindings.xed_operand_convert_enum_t2str a0
  let operand_element_type_of_string (a0 : string) : XedBindingsEnums.operand_element_type =
    Bindings.str2xed_operand_element_type_enum_t a0
  let operand_element_type_to_string (a0 : XedBindingsEnums.operand_element_type) : string =
    Bindings.xed_operand_element_type_enum_t2str a0
  let operand_element_xtype_of_string (a0 : string) : XedBindingsEnums.operand_element_xtype =
    Bindings.str2xed_operand_element_xtype_enum_t a0
  let operand_element_xtype_to_string (a0 : XedBindingsEnums.operand_element_xtype) : string =
    Bindings.xed_operand_element_xtype_enum_t2str a0
  let operand_of_string (a0 : string) : XedBindingsEnums.operand =
    Bindings.str2xed_operand_enum_t a0
  let operand_to_string (a0 : XedBindingsEnums.operand) : string =
    Bindings.xed_operand_enum_t2str a0
  let operand_type_of_string (a0 : string) : XedBindingsEnums.operand_type =
    Bindings.str2xed_operand_type_enum_t a0
  let operand_type_to_string (a0 : XedBindingsEnums.operand_type) : string =
    Bindings.xed_operand_type_enum_t2str a0
  let operand_visibility_of_string (a0 : string) : XedBindingsEnums.operand_visibility =
    Bindings.str2xed_operand_visibility_enum_t a0
  let operand_visibility_to_string (a0 : XedBindingsEnums.operand_visibility) : string =
    Bindings.xed_operand_visibility_enum_t2str a0
  let operand_width_of_string (a0 : string) : XedBindingsEnums.operand_width =
    Bindings.str2xed_operand_width_enum_t a0
  let operand_width_to_string (a0 : XedBindingsEnums.operand_width) : string =
    Bindings.xed_operand_width_enum_t2str a0
  let reg_class_of_string (a0 : string) : XedBindingsEnums.reg_class =
    Bindings.str2xed_reg_class_enum_t a0
  let reg_class_to_string (a0 : XedBindingsEnums.reg_class) : string =
    Bindings.xed_reg_class_enum_t2str a0
  let reg_of_string (a0 : string) : XedBindingsEnums.reg =
    Bindings.str2xed_reg_enum_t a0
  let reg_to_string (a0 : XedBindingsEnums.reg) : string =
    Bindings.xed_reg_enum_t2str a0
  let syntax_of_string (a0 : string) : XedBindingsEnums.syntax =
    Bindings.str2xed_syntax_enum_t a0
  let syntax_to_string (a0 : XedBindingsEnums.syntax) : string =
    Bindings.xed_syntax_enum_t2str a0
  let cpuid_bit_for_isa_set (a0 : XedBindingsEnums.isa_set) (a1 : int) : XedBindingsEnums.cpuid_bit =
    assert (a1 >= 0);
    Bindings.xed_get_cpuid_bit_for_isa_set a0 a1
  let flag_action_action_invalid (a0 : XedBindingsEnums.flag_action) : bool =
    Bindings.xed_flag_action_action_invalid a0
  let flag_action_read_action (a0 : XedBindingsEnums.flag_action) : bool =
    Bindings.xed_flag_action_read_action a0
  let flag_action_write_action (a0 : XedBindingsEnums.flag_action) : bool =
    Bindings.xed_flag_action_write_action a0
  let gpr_reg_class (a0 : XedBindingsEnums.reg) : XedBindingsEnums.reg_class =
    Bindings.xed_gpr_reg_class a0
  let iclass_norep_map (a0 : XedBindingsEnums.iclass) : XedBindingsEnums.iclass =
    Bindings.xed_norep_map a0
  let iclass_rep_map (a0 : XedBindingsEnums.iclass) : XedBindingsEnums.iclass =
    Bindings.xed_rep_map a0
  let iclass_rep_remove (a0 : XedBindingsEnums.iclass) : XedBindingsEnums.iclass =
    Bindings.xed_rep_remove a0
  let iclass_repe_map (a0 : XedBindingsEnums.iclass) : XedBindingsEnums.iclass =
    Bindings.xed_repe_map a0
  let iclass_repne_map (a0 : XedBindingsEnums.iclass) : XedBindingsEnums.iclass =
    Bindings.xed_repne_map a0
  let iform_first_per_iclass (a0 : XedBindingsEnums.iclass) : Unsigned.UInt32.t =
    Bindings.xed_iform_first_per_iclass a0
  let iform_max_per_iclass (a0 : XedBindingsEnums.iclass) : Unsigned.UInt32.t =
    Bindings.xed_iform_max_per_iclass a0
  let iform_to_category (a0 : XedBindingsEnums.iform) : XedBindingsEnums.category =
    Bindings.xed_iform_to_category a0
  let iform_to_extension (a0 : XedBindingsEnums.iform) : XedBindingsEnums.extension =
    Bindings.xed_iform_to_extension a0
  let iform_to_iclass (a0 : XedBindingsEnums.iform) : XedBindingsEnums.iclass =
    Bindings.xed_iform_to_iclass a0
  let iform_to_iclass_string_att (a0 : XedBindingsEnums.iform) : string =
    Bindings.xed_iform_to_iclass_string_att a0
  let iform_to_iclass_string_intel (a0 : XedBindingsEnums.iform) : string =
    Bindings.xed_iform_to_iclass_string_intel a0
  let iform_to_isa_set (a0 : XedBindingsEnums.iform) : XedBindingsEnums.isa_set =
    Bindings.xed_iform_to_isa_set a0
  let isa_set_is_valid_for_chip (a0 : XedBindingsEnums.isa_set) (a1 : XedBindingsEnums.chip) : bool =
    Bindings.xed_isa_set_is_valid_for_chip a0 a1
  let largest_enclosing_register (a0 : XedBindingsEnums.reg) : XedBindingsEnums.reg =
    Bindings.xed_get_largest_enclosing_register a0
  let largest_enclosing_register32 (a0 : XedBindingsEnums.reg) : XedBindingsEnums.reg =
    Bindings.xed_get_largest_enclosing_register32 a0
  let operand_action_conditional_read (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_conditional_read a0
  let operand_action_conditional_write (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_conditional_write a0
  let operand_action_read (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_read a0
  let operand_action_read_and_written (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_read_and_written a0
  let operand_action_read_only (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_read_only a0
  let operand_action_written (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_written a0
  let operand_action_written_only (a0 : XedBindingsEnums.operand_action) : int =
    Bindings.xed_operand_action_written_only a0
  let operand_is_memory_addressing_register (a0 : XedBindingsEnums.operand) : int =
    Bindings.xed_operand_is_memory_addressing_register a0
  let operand_is_register (a0 : XedBindingsEnums.operand) : int =
    Bindings.xed_operand_is_register a0
  let reg_class (a0 : XedBindingsEnums.reg) : XedBindingsEnums.reg_class =
    Bindings.xed_reg_class a0
  let register_width_bits (a0 : XedBindingsEnums.reg) : Unsigned.UInt32.t =
    Bindings.xed_get_register_width_bits a0
  let register_width_bits64 (a0 : XedBindingsEnums.reg) : Unsigned.UInt32.t =
    Bindings.xed_get_register_width_bits64 a0
end

module Enc = struct
  let disp (a0 : Signed.Int64.t) (a1 : Unsigned.UInt32.t) : XedBindingsStubs.enc_displacement =
    Bindings.xed_disp a0 a1
  let imm0 (a0 : Unsigned.UInt64.t) (a1 : int) : XedBindingsStubs.encoder_operand =
    assert (a1 >= 0);
    Bindings.xed_imm0 a0 a1
  let imm1 (a0 : char) : XedBindingsStubs.encoder_operand =
    Bindings.xed_imm1 a0
  let mem_b (a0 : XedBindingsEnums.reg) (a1 : int) : XedBindingsStubs.encoder_operand =
    assert (a1 >= 0);
    Bindings.xed_mem_b a0 a1
  let mem_bd (a0 : XedBindingsEnums.reg) (a1 : XedBindingsStubs.enc_displacement) (a2 : int) : XedBindingsStubs.encoder_operand =
    assert (a2 >= 0);
    Bindings.xed_mem_bd a0 a1 a2
  let mem_bisd (a0 : XedBindingsEnums.reg) (a1 : XedBindingsEnums.reg) (a2 : int) (a3 : XedBindingsStubs.enc_displacement) (a4 : int) : XedBindingsStubs.encoder_operand =
    assert (a2 >= 0 && a4 >= 0);
    Bindings.xed_mem_bisd a0 a1 a2 a3 a4
  let mem_gb (a0 : XedBindingsEnums.reg) (a1 : XedBindingsEnums.reg) (a2 : int) : XedBindingsStubs.encoder_operand =
    assert (a2 >= 0);
    Bindings.xed_mem_gb a0 a1 a2
  let mem_gbd (a0 : XedBindingsEnums.reg) (a1 : XedBindingsEnums.reg) (a2 : XedBindingsStubs.enc_displacement) (a3 : int) : XedBindingsStubs.encoder_operand =
    assert (a3 >= 0);
    Bindings.xed_mem_gbd a0 a1 a2 a3
  let mem_gbisd (a0 : XedBindingsEnums.reg) (a1 : XedBindingsEnums.reg) (a2 : XedBindingsEnums.reg) (a3 : int) (a4 : XedBindingsStubs.enc_displacement) (a5 : int) : XedBindingsStubs.encoder_operand =
    assert (a3 >= 0 && a5 >= 0);
    Bindings.xed_mem_gbisd a0 a1 a2 a3 a4 a5
  let mem_gd (a0 : XedBindingsEnums.reg) (a1 : XedBindingsStubs.enc_displacement) (a2 : int) : XedBindingsStubs.encoder_operand =
    assert (a2 >= 0);
    Bindings.xed_mem_gd a0 a1 a2
  let other (a0 : XedBindingsEnums.operand) (a1 : Signed.Int32.t) : XedBindingsStubs.encoder_operand =
    Bindings.xed_other a0 a1
  let ptr (a0 : Signed.Int32.t) (a1 : int) : XedBindingsStubs.encoder_operand =
    assert (a1 >= 0);
    Bindings.xed_ptr a0 a1
  let reg (a0 : XedBindingsEnums.reg) : XedBindingsStubs.encoder_operand =
    Bindings.xed_reg a0
  let relbr (a0 : Signed.Int32.t) (a1 : int) : XedBindingsStubs.encoder_operand =
    assert (a1 >= 0);
    Bindings.xed_relbr a0 a1
  let seg0 (a0 : XedBindingsEnums.reg) : XedBindingsStubs.encoder_operand =
    Bindings.xed_seg0 a0
  let seg1 (a0 : XedBindingsEnums.reg) : XedBindingsStubs.encoder_operand =
    Bindings.xed_seg1 a0
  let simm0 (a0 : Signed.Int32.t) (a1 : int) : XedBindingsStubs.encoder_operand =
    assert (a1 >= 0);
    Bindings.xed_simm0 a0 a1
end

(* other *)
let xed_attribute (a0 : int) : XedBindingsEnums.attribute =
  assert (a0 >= 0);
  Bindings.xed_attribute a0
let xed_attribute_max () : int =
  Bindings.xed_attribute_max ()
let xed_encode_nop (a0 : bytes) : XedBindingsEnums.error =
  Bindings.xed_encode_nop (Ctypes.ocaml_bytes_start a0) (Bytes.length a0)
let xed_get_copyright () : string =
  Bindings.xed_get_copyright ()
let xed_get_version () : string =
  Bindings.xed_get_version ()
let xed_set_verbosity (a0 : int) : unit =
  Bindings.xed_set_verbosity a0
let xed_tables_init () : unit =
  Bindings.xed_tables_init ()
