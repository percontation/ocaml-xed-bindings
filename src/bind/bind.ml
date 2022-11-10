module Funcs = C.Function
module Types = Types_generated
module Ptr = Types.Ptr

module ChipFeatures = struct
  type -'perm t = (Types.chip_features Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.chip_features
  let get_chip_features (a0 : [>`Read|`Write] Types.chip_features_ptr) (a1 : XBEnums.chip) : unit =
    Funcs.xed_get_chip_features (Ptr.unsafe_get a0) a1
  let modify_chip_features (a0 : [>`Read|`Write] Types.chip_features_ptr) (a1 : XBEnums.isa_set) (a2 : bool) : unit =
    Funcs.xed_modify_chip_features (Ptr.unsafe_get a0) a1 a2
end

module DecodedInst = struct
  type -'perm t = (Types.decoded_inst Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.decoded_inst
  let avx512_dest_elements (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_avx512_dest_elements (Ptr.unsafe_get a0)
  let classify_amx (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_classify_amx (Ptr.unsafe_get a0)
  let classify_avx (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_classify_avx (Ptr.unsafe_get a0)
  let classify_avx512 (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_classify_avx512 (Ptr.unsafe_get a0)
  let classify_avx512_maskop (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_classify_avx512_maskop (Ptr.unsafe_get a0)
  let classify_sse (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_classify_sse (Ptr.unsafe_get a0)
  let conditionally_writes_registers (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_conditionally_writes_registers (Ptr.unsafe_get a0)
  let decode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : string) : XBEnums.error =
    Funcs.xed_decode (Ptr.unsafe_get a0) (Ctypes.ocaml_string_start a1) (String.length a1)
  let decode_with_features (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : string) (a3 : [>`Read|`Write] Types.chip_features_ptr) : XBEnums.error =
    Funcs.xed_decode_with_features (Ptr.unsafe_get a0) (Ctypes.ocaml_string_start a1) (String.length a1) (Ptr.unsafe_get a3)
  let dump (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : bytes) : unit =
    Funcs.xed_decoded_inst_dump (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let dump_xed_format (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : bytes) (a3 : Unsigned.UInt64.t) : bool =
    Funcs.xed_decoded_inst_dump_xed_format (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1) a3
  let get_attribute (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : XBEnums.attribute) : Unsigned.UInt32.t =
    Funcs.xed_decoded_inst_get_attribute (Ptr.unsafe_get a0) a1
  let get_base_reg (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_base_reg (Ptr.unsafe_get a0) a1
  let get_branch_displacement (a0 : [>`Read] Types.decoded_inst_ptr) : Signed.Int32.t =
    Funcs.xed_decoded_inst_get_branch_displacement (Ptr.unsafe_get a0)
  let get_branch_displacement_width (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_branch_displacement_width (Ptr.unsafe_get a0)
  let get_branch_displacement_width_bits (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_branch_displacement_width_bits (Ptr.unsafe_get a0)
  let get_byte (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : char =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_byte (Ptr.unsafe_get a0) a1
  let get_category (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.category =
    Funcs.xed_decoded_inst_get_category (Ptr.unsafe_get a0)
  let get_extension (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.extension =
    Funcs.xed_decoded_inst_get_extension (Ptr.unsafe_get a0)
  let get_iclass (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.iclass =
    Funcs.xed_decoded_inst_get_iclass (Ptr.unsafe_get a0)
  let get_iform_enum (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.iform =
    Funcs.xed_decoded_inst_get_iform_enum (Ptr.unsafe_get a0)
  let get_iform_enum_dispatch (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_iform_enum_dispatch (Ptr.unsafe_get a0)
  let get_immediate_is_signed (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_immediate_is_signed (Ptr.unsafe_get a0)
  let get_immediate_width (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_immediate_width (Ptr.unsafe_get a0)
  let get_immediate_width_bits (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_immediate_width_bits (Ptr.unsafe_get a0)
  let get_index_reg (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_index_reg (Ptr.unsafe_get a0) a1
  let get_input_chip (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.chip =
    Funcs.xed_decoded_inst_get_input_chip (Ptr.unsafe_get a0)
  let get_isa_set (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.isa_set =
    Funcs.xed_decoded_inst_get_isa_set (Ptr.unsafe_get a0)
  let get_length (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_length (Ptr.unsafe_get a0)
  let get_machine_mode_bits (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_machine_mode_bits (Ptr.unsafe_get a0)
  let get_memop_address_width (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_memop_address_width (Ptr.unsafe_get a0) a1
  let get_memory_displacement (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : Signed.Int64.t =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_memory_displacement (Ptr.unsafe_get a0) a1
  let get_memory_displacement_width (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_memory_displacement_width (Ptr.unsafe_get a0) a1
  let get_memory_displacement_width_bits (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_memory_displacement_width_bits (Ptr.unsafe_get a0) a1
  let get_memory_operand_length (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_memory_operand_length (Ptr.unsafe_get a0) a1
  let get_modrm (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed_decoded_inst_get_modrm (Ptr.unsafe_get a0)
  let get_nprefixes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_nprefixes (Ptr.unsafe_get a0)
  let get_operand_width (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt32.t =
    Funcs.xed_decoded_inst_get_operand_width (Ptr.unsafe_get a0)
  let get_reg (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : XBEnums.operand) : XBEnums.reg =
    Funcs.xed_decoded_inst_get_reg (Ptr.unsafe_get a0) a1
  let get_rflags_info (a0 : [>`Read] Types.decoded_inst_ptr) : [<`Read] Types.simple_flag_ptr =
    Funcs.xed_decoded_inst_get_rflags_info (Ptr.unsafe_get a0) |> Ptr.ro
  let get_scale (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_scale (Ptr.unsafe_get a0) a1
  let get_second_immediate (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed_decoded_inst_get_second_immediate (Ptr.unsafe_get a0)
  let get_seg_reg (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_get_seg_reg (Ptr.unsafe_get a0) a1
  let get_signed_immediate (a0 : [>`Read] Types.decoded_inst_ptr) : Signed.Int32.t =
    Funcs.xed_decoded_inst_get_signed_immediate (Ptr.unsafe_get a0)
  let get_stack_address_mode_bits (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_get_stack_address_mode_bits (Ptr.unsafe_get a0)
  let get_unsigned_immediate (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt64.t =
    Funcs.xed_decoded_inst_get_unsigned_immediate (Ptr.unsafe_get a0)
  let get_user_data (a0 : [>`Read|`Write] Types.decoded_inst_ptr) : Unsigned.UInt64.t =
    Funcs.xed_decoded_inst_get_user_data (Ptr.unsafe_get a0)
  let has_mpx_prefix (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt32.t =
    Funcs.xed_decoded_inst_has_mpx_prefix (Ptr.unsafe_get a0)
  let ild_decode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : string) : XBEnums.error =
    Funcs.xed_ild_decode (Ptr.unsafe_get a0) (Ctypes.ocaml_string_start a1) (String.length a1)
  let inst (a0 : [>`Read] Types.decoded_inst_ptr) : [<`Read] Types.inst_ptr =
    Funcs.xed_decoded_inst_inst (Ptr.unsafe_get a0) |> Ptr.ro
  let is_broadcast (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_is_broadcast (Ptr.unsafe_get a0)
  let is_broadcast_instruction (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_is_broadcast_instruction (Ptr.unsafe_get a0)
  let is_prefetch (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_is_prefetch (Ptr.unsafe_get a0)
  let is_xacquire (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt32.t =
    Funcs.xed_decoded_inst_is_xacquire (Ptr.unsafe_get a0)
  let is_xrelease (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt32.t =
    Funcs.xed_decoded_inst_is_xrelease (Ptr.unsafe_get a0)
  let masked_vector_operation (a0 : [>`Read|`Write] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_masked_vector_operation (Ptr.unsafe_get a0)
  let masking (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_masking (Ptr.unsafe_get a0)
  let mem_read (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : bool =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_mem_read (Ptr.unsafe_get a0) a1
  let mem_written (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : bool =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_mem_written (Ptr.unsafe_get a0) a1
  let mem_written_only (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : bool =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_mem_written_only (Ptr.unsafe_get a0) a1
  let merging (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_merging (Ptr.unsafe_get a0)
  let noperands (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_noperands (Ptr.unsafe_get a0)
  let number_of_memory_operands (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_number_of_memory_operands (Ptr.unsafe_get a0)
  let operand_action (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : XBEnums.operand_action =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_action (Ptr.unsafe_get a0) a1
  let operand_element_size_bits (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_element_size_bits (Ptr.unsafe_get a0) a1
  let operand_element_type (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : XBEnums.operand_element_type =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_element_type (Ptr.unsafe_get a0) a1
  let operand_elements (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_elements (Ptr.unsafe_get a0) a1
  let operand_length (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_length (Ptr.unsafe_get a0) a1
  let operand_length_bits (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_operand_length_bits (Ptr.unsafe_get a0) a1
  let operands (a0 : [>`Read|`Write] Types.decoded_inst_ptr) : [<`Read|`Write] Types.operand_values_ptr =
    Funcs.xed_decoded_inst_operands (Ptr.unsafe_get a0) |> Ptr.rw
  let operands_const (a0 : [>`Read] Types.decoded_inst_ptr) : [<`Read] Types.operand_values_ptr =
    Funcs.xed_decoded_inst_operands_const (Ptr.unsafe_get a0) |> Ptr.ro
  let set_branch_displacement (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_branch_displacement (Ptr.unsafe_get a0) a1 a2
  let set_branch_displacement_bits (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_branch_displacement_bits (Ptr.unsafe_get a0) a1 a2
  let set_immediate_signed (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_immediate_signed (Ptr.unsafe_get a0) a1 a2
  let set_immediate_signed_bits (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_immediate_signed_bits (Ptr.unsafe_get a0) a1 a2
  let set_immediate_unsigned (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_immediate_unsigned (Ptr.unsafe_get a0) a1 a2
  let set_immediate_unsigned_bits (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_immediate_unsigned_bits (Ptr.unsafe_get a0) a1 a2
  let set_input_chip (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.chip) : unit =
    Funcs.xed_decoded_inst_set_input_chip (Ptr.unsafe_get a0) a1
  let set_memory_displacement (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_memory_displacement (Ptr.unsafe_get a0) a1 a2
  let set_memory_displacement_bits (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_decoded_inst_set_memory_displacement_bits (Ptr.unsafe_get a0) a1 a2
  let set_mode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.machine_mode) (a2 : XBEnums.address_width) : unit =
    Funcs.xed_decoded_inst_set_mode (Ptr.unsafe_get a0) a1 a2
  let set_scale (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_decoded_inst_set_scale (Ptr.unsafe_get a0) a1
  let set_user_data (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Unsigned.UInt64.t) : unit =
    Funcs.xed_decoded_inst_set_user_data (Ptr.unsafe_get a0) a1
  let uses_embedded_broadcast (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_uses_embedded_broadcast (Ptr.unsafe_get a0)
  let uses_rflags (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_uses_rflags (Ptr.unsafe_get a0)
  let valid (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_valid (Ptr.unsafe_get a0)
  let valid_for_chip (a0 : [>`Read] Types.decoded_inst_ptr) (a1 : XBEnums.chip) : bool =
    Funcs.xed_decoded_inst_valid_for_chip (Ptr.unsafe_get a0) a1
  let vector_length_bits (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed_decoded_inst_vector_length_bits (Ptr.unsafe_get a0)
  let zero (a0 : [>`Read|`Write] Types.decoded_inst_ptr) : unit =
    Funcs.xed_decoded_inst_zero (Ptr.unsafe_get a0)
  let zero_keep_mode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) : unit =
    Funcs.xed_decoded_inst_zero_keep_mode (Ptr.unsafe_get a0)
  let zero_keep_mode_from_operands (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : [>`Read] Types.operand_values_ptr) : unit =
    Funcs.xed_decoded_inst_zero_keep_mode_from_operands (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
  let zero_set_mode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : [>`Read] Types.state_ptr) : unit =
    Funcs.xed_decoded_inst_zero_set_mode (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
  let zeroing (a0 : [>`Read] Types.decoded_inst_ptr) : bool =
    Funcs.xed_decoded_inst_zeroing (Ptr.unsafe_get a0)
end

module EncoderInstruction = struct
  type -'perm t = (Types.encoder_instruction Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.encoder_instruction
  let addr (a0 : [>`Read|`Write] Types.encoder_instruction_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_addr (Ptr.unsafe_get a0) a1
  let rep (a0 : [>`Read|`Write] Types.encoder_instruction_ptr) : unit =
    Funcs.xed_rep (Ptr.unsafe_get a0)
  let repne (a0 : [>`Read|`Write] Types.encoder_instruction_ptr) : unit =
    Funcs.xed_repne (Ptr.unsafe_get a0)
end

module EncoderRequest = struct
  type -'perm t = (Types.encoder_request Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.encoder_request
  let convert_to_encoder_request (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : [>`Read|`Write] Types.encoder_instruction_ptr) : bool =
    Funcs.xed_convert_to_encoder_request (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
  let get_iclass (a0 : [>`Read] Types.encoder_request_ptr) : XBEnums.iclass =
    Funcs.xed_encoder_request_get_iclass (Ptr.unsafe_get a0)
  let get_operand_order (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) : XBEnums.operand =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_get_operand_order (Ptr.unsafe_get a0) a1
  let operand_order_entries (a0 : [>`Read|`Write] Types.encoder_request_ptr) : int =
    Funcs.xed_encoder_request_operand_order_entries (Ptr.unsafe_get a0)
  let operands (a0 : [>`Read|`Write] Types.encoder_request_ptr) : [<`Read|`Write] Types.operand_values_ptr =
    Funcs.xed_encoder_request_operands (Ptr.unsafe_get a0) |> Ptr.rw
  let operands_const (a0 : [>`Read] Types.encoder_request_ptr) : [<`Read] Types.operand_values_ptr =
    Funcs.xed_encoder_request_operands_const (Ptr.unsafe_get a0) |> Ptr.ro
  let print (a0 : [>`Read] Types.encoder_request_ptr) (a1 : bytes) : unit =
    Funcs.xed_encode_request_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let set_agen (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_set_agen (Ptr.unsafe_get a0)
  let set_base0 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_base0 (Ptr.unsafe_get a0) a1
  let set_base1 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_base1 (Ptr.unsafe_get a0) a1
  let set_branch_displacement (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_encoder_request_set_branch_displacement (Ptr.unsafe_get a0) a1 a2
  let set_effective_address_size (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_set_effective_address_size (Ptr.unsafe_get a0) a1
  let set_effective_operand_width (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_set_effective_operand_width (Ptr.unsafe_get a0) a1
  let set_iclass (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.iclass) : unit =
    Funcs.xed_encoder_request_set_iclass (Ptr.unsafe_get a0) a1
  let set_index (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_index (Ptr.unsafe_get a0) a1
  let set_mem0 (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_set_mem0 (Ptr.unsafe_get a0)
  let set_mem1 (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_set_mem1 (Ptr.unsafe_get a0)
  let set_memory_displacement (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_encoder_request_set_memory_displacement (Ptr.unsafe_get a0) a1 a2
  let set_memory_operand_length (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_set_memory_operand_length (Ptr.unsafe_get a0) a1
  let set_operand_order (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) (a2 : XBEnums.operand) : unit =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_set_operand_order (Ptr.unsafe_get a0) a1 a2
  let set_ptr (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_set_ptr (Ptr.unsafe_get a0)
  let set_reg (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.operand) (a2 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_reg (Ptr.unsafe_get a0) a1 a2
  let set_relbr (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_set_relbr (Ptr.unsafe_get a0)
  let set_scale (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_encoder_request_set_scale (Ptr.unsafe_get a0) a1
  let set_seg0 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_seg0 (Ptr.unsafe_get a0) a1
  let set_seg1 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed_encoder_request_set_seg1 (Ptr.unsafe_get a0) a1
  let set_simm (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_encoder_request_set_simm (Ptr.unsafe_get a0) a1 a2
  let set_uimm0 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_encoder_request_set_uimm0 (Ptr.unsafe_get a0) a1 a2
  let set_uimm0_bits (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_encoder_request_set_uimm0_bits (Ptr.unsafe_get a0) a1 a2
  let set_uimm1 (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : char) : unit =
    Funcs.xed_encoder_request_set_uimm1 (Ptr.unsafe_get a0) a1
  let zero (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_zero (Ptr.unsafe_get a0)
  let zero_operand_order (a0 : [>`Read|`Write] Types.encoder_request_ptr) : unit =
    Funcs.xed_encoder_request_zero_operand_order (Ptr.unsafe_get a0)
  let zero_set_mode (a0 : [>`Read|`Write] Types.encoder_request_ptr) (a1 : [>`Read] Types.state_ptr) : unit =
    Funcs.xed_encoder_request_zero_set_mode (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
end

module FlagAction = struct
  type -'perm t = (Types.flag_action Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.flag_action
  let get_action (a0 : [>`Read] Types.flag_action_ptr) (a1 : int) : XBEnums.flag_action =
    assert (a1 >= 0);
    Funcs.xed_flag_action_get_action (Ptr.unsafe_get a0) a1
  let get_flag_name (a0 : [>`Read] Types.flag_action_ptr) : XBEnums.flag =
    Funcs.xed_flag_action_get_flag_name (Ptr.unsafe_get a0)
  let print (a0 : [>`Read] Types.flag_action_ptr) (a1 : bytes) : int =
    Funcs.xed_flag_action_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let read_flag (a0 : [>`Read] Types.flag_action_ptr) : bool =
    Funcs.xed_flag_action_read_flag (Ptr.unsafe_get a0)
  let writes_flag (a0 : [>`Read] Types.flag_action_ptr) : bool =
    Funcs.xed_flag_action_writes_flag (Ptr.unsafe_get a0)
end

module FlagSet = struct
  type -'perm t = (Types.flag_set Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.flag_set
  let is_subset_of (a0 : [>`Read] Types.flag_set_ptr) (a1 : [>`Read] Types.flag_set_ptr) : bool =
    Funcs.xed_flag_set_is_subset_of (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
  let mask (a0 : [>`Read] Types.flag_set_ptr) : int =
    Funcs.xed_flag_set_mask (Ptr.unsafe_get a0)
  let print (a0 : [>`Read] Types.flag_set_ptr) (a1 : bytes) : int =
    Funcs.xed_flag_set_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
end

module Inst = struct
  type -'perm t = (Types.inst Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.inst
  let category (a0 : [>`Read] Types.inst_ptr) : XBEnums.category =
    Funcs.xed_inst_category (Ptr.unsafe_get a0)
  let cpl (a0 : [>`Read] Types.inst_ptr) : int =
    Funcs.xed_inst_cpl (Ptr.unsafe_get a0)
  let extension (a0 : [>`Read] Types.inst_ptr) : XBEnums.extension =
    Funcs.xed_inst_extension (Ptr.unsafe_get a0)
  let flag_info_index (a0 : [>`Read] Types.inst_ptr) : Unsigned.UInt32.t =
    Funcs.xed_inst_flag_info_index (Ptr.unsafe_get a0)
  let get_attribute (a0 : [>`Read] Types.inst_ptr) (a1 : XBEnums.attribute) : Unsigned.UInt32.t =
    Funcs.xed_inst_get_attribute (Ptr.unsafe_get a0) a1
  let iclass (a0 : [>`Read] Types.inst_ptr) : XBEnums.iclass =
    Funcs.xed_inst_iclass (Ptr.unsafe_get a0)
  let iexception (a0 : [>`Read] Types.inst_ptr) : XBEnums.iexception =
    Funcs.xed_inst_exception (Ptr.unsafe_get a0)
  let iform_enum (a0 : [>`Read] Types.inst_ptr) : XBEnums.iform =
    Funcs.xed_inst_iform_enum (Ptr.unsafe_get a0)
  let isa_set (a0 : [>`Read] Types.inst_ptr) : XBEnums.isa_set =
    Funcs.xed_inst_isa_set (Ptr.unsafe_get a0)
  let noperands (a0 : [>`Read] Types.inst_ptr) : int =
    Funcs.xed_inst_noperands (Ptr.unsafe_get a0)
  let operand (a0 : [>`Read] Types.inst_ptr) (a1 : int) : [<`Read] Types.operand_ptr =
    assert (a1 >= 0);
    Funcs.xed_inst_operand (Ptr.unsafe_get a0) a1 |> Ptr.ro
end

module Operand = struct
  type -'perm t = (Types.operand Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.operand
  let conditional_read (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_conditional_read (Ptr.unsafe_get a0)
  let conditional_write (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_conditional_write (Ptr.unsafe_get a0)
  let imm (a0 : [>`Read] Types.operand_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_imm (Ptr.unsafe_get a0)
  let name (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand =
    Funcs.xed_operand_name (Ptr.unsafe_get a0)
  let nonterminal_name (a0 : [>`Read] Types.operand_ptr) : XBEnums.nonterminal =
    Funcs.xed_operand_nonterminal_name (Ptr.unsafe_get a0)
  let op_type (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand_type =
    Funcs.xed_operand_type (Ptr.unsafe_get a0)
  let print (a0 : [>`Read] Types.operand_ptr) (a1 : bytes) : unit =
    Funcs.xed_operand_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let read (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_read (Ptr.unsafe_get a0)
  let read_and_written (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_read_and_written (Ptr.unsafe_get a0)
  let read_only (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_read_only (Ptr.unsafe_get a0)
  let reg (a0 : [>`Read] Types.operand_ptr) : XBEnums.reg =
    Funcs.xed_operand_reg (Ptr.unsafe_get a0)
  let rw (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand_action =
    Funcs.xed_operand_rw (Ptr.unsafe_get a0)
  let template_is_register (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_template_is_register (Ptr.unsafe_get a0)
  let visibility (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand_visibility =
    Funcs.xed_operand_operand_visibility (Ptr.unsafe_get a0)
  let width (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand_width =
    Funcs.xed_operand_width (Ptr.unsafe_get a0)
  let width_bits (a0 : [>`Read] Types.operand_ptr) (a1 : Unsigned.UInt32.t) : Unsigned.UInt32.t =
    Funcs.xed_operand_width_bits (Ptr.unsafe_get a0) a1
  let written (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_written (Ptr.unsafe_get a0)
  let written_only (a0 : [>`Read] Types.operand_ptr) : int =
    Funcs.xed_operand_written_only (Ptr.unsafe_get a0)
  let xtype (a0 : [>`Read] Types.operand_ptr) : XBEnums.operand_element_xtype =
    Funcs.xed_operand_xtype (Ptr.unsafe_get a0)
end

module Operand3 = struct
  let get_agen (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_agen (Ptr.unsafe_get a0)
  let get_amd3dnow (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_amd3dnow (Ptr.unsafe_get a0)
  let get_asz (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_asz (Ptr.unsafe_get a0)
  let get_base0 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_base0 (Ptr.unsafe_get a0)
  let get_base1 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_base1 (Ptr.unsafe_get a0)
  let get_bcast (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_bcast (Ptr.unsafe_get a0)
  let get_bcrc (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_bcrc (Ptr.unsafe_get a0)
  let get_brdisp_width (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed3_operand_get_brdisp_width (Ptr.unsafe_get a0)
  let get_cet (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_cet (Ptr.unsafe_get a0)
  let get_chip (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.chip =
    Funcs.xed3_operand_get_chip (Ptr.unsafe_get a0)
  let get_cldemote (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_cldemote (Ptr.unsafe_get a0)
  let get_default_seg (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_default_seg (Ptr.unsafe_get a0)
  let get_df32 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_df32 (Ptr.unsafe_get a0)
  let get_df64 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_df64 (Ptr.unsafe_get a0)
  let get_disp (a0 : [>`Read] Types.decoded_inst_ptr) : Signed.Int64.t =
    Funcs.xed3_operand_get_disp (Ptr.unsafe_get a0)
  let get_disp_width (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed3_operand_get_disp_width (Ptr.unsafe_get a0)
  let get_dummy (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_dummy (Ptr.unsafe_get a0)
  let get_easz (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_easz (Ptr.unsafe_get a0)
  let get_element_size (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_element_size (Ptr.unsafe_get a0)
  let get_encode_force (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_encode_force (Ptr.unsafe_get a0)
  let get_encoder_preferred (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_encoder_preferred (Ptr.unsafe_get a0)
  let get_eosz (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_eosz (Ptr.unsafe_get a0)
  let get_error (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.error =
    Funcs.xed3_operand_get_error (Ptr.unsafe_get a0)
  let get_esrc (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_esrc (Ptr.unsafe_get a0)
  let get_first_f2f3 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_first_f2f3 (Ptr.unsafe_get a0)
  let get_has_modrm (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_has_modrm (Ptr.unsafe_get a0)
  let get_has_sib (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_has_sib (Ptr.unsafe_get a0)
  let get_hint (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_hint (Ptr.unsafe_get a0)
  let get_iclass (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.iclass =
    Funcs.xed3_operand_get_iclass (Ptr.unsafe_get a0)
  let get_ild_f2 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_ild_f2 (Ptr.unsafe_get a0)
  let get_ild_f3 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_ild_f3 (Ptr.unsafe_get a0)
  let get_ild_seg (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_ild_seg (Ptr.unsafe_get a0)
  let get_imm0 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_imm0 (Ptr.unsafe_get a0)
  let get_imm0signed (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_imm0signed (Ptr.unsafe_get a0)
  let get_imm1 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_imm1 (Ptr.unsafe_get a0)
  let get_imm1_bytes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_imm1_bytes (Ptr.unsafe_get a0)
  let get_imm_width (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed3_operand_get_imm_width (Ptr.unsafe_get a0)
  let get_index (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_index (Ptr.unsafe_get a0)
  let get_last_f2f3 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_last_f2f3 (Ptr.unsafe_get a0)
  let get_llrc (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_llrc (Ptr.unsafe_get a0)
  let get_lock (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_lock (Ptr.unsafe_get a0)
  let get_lzcnt (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_lzcnt (Ptr.unsafe_get a0)
  let get_map (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_map (Ptr.unsafe_get a0)
  let get_mask (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mask (Ptr.unsafe_get a0)
  let get_max_bytes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_max_bytes (Ptr.unsafe_get a0)
  let get_mem0 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mem0 (Ptr.unsafe_get a0)
  let get_mem1 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mem1 (Ptr.unsafe_get a0)
  let get_mem_width (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt16.t =
    Funcs.xed3_operand_get_mem_width (Ptr.unsafe_get a0)
  let get_mod (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mod (Ptr.unsafe_get a0)
  let get_mode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mode (Ptr.unsafe_get a0)
  let get_mode_first_prefix (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mode_first_prefix (Ptr.unsafe_get a0)
  let get_mode_short_ud0 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mode_short_ud0 (Ptr.unsafe_get a0)
  let get_modep5 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_modep5 (Ptr.unsafe_get a0)
  let get_modep55c (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_modep55c (Ptr.unsafe_get a0)
  let get_modrm_byte (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_modrm_byte (Ptr.unsafe_get a0)
  let get_mpxmode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_mpxmode (Ptr.unsafe_get a0)
  let get_must_use_evex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_must_use_evex (Ptr.unsafe_get a0)
  let get_need_memdisp (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_need_memdisp (Ptr.unsafe_get a0)
  let get_need_sib (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_need_sib (Ptr.unsafe_get a0)
  let get_needrex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_needrex (Ptr.unsafe_get a0)
  let get_nelem (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_nelem (Ptr.unsafe_get a0)
  let get_no_evex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_no_evex (Ptr.unsafe_get a0)
  let get_no_vex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_no_vex (Ptr.unsafe_get a0)
  let get_nominal_opcode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_nominal_opcode (Ptr.unsafe_get a0)
  let get_norex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_norex (Ptr.unsafe_get a0)
  let get_nprefixes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_nprefixes (Ptr.unsafe_get a0)
  let get_nrexes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_nrexes (Ptr.unsafe_get a0)
  let get_nseg_prefixes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_nseg_prefixes (Ptr.unsafe_get a0)
  let get_osz (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_osz (Ptr.unsafe_get a0)
  let get_out_of_bytes (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_out_of_bytes (Ptr.unsafe_get a0)
  let get_outreg (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_outreg (Ptr.unsafe_get a0)
  let get_p4 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_p4 (Ptr.unsafe_get a0)
  let get_pos_disp (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_disp (Ptr.unsafe_get a0)
  let get_pos_imm (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_imm (Ptr.unsafe_get a0)
  let get_pos_imm1 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_imm1 (Ptr.unsafe_get a0)
  let get_pos_modrm (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_modrm (Ptr.unsafe_get a0)
  let get_pos_nominal_opcode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_nominal_opcode (Ptr.unsafe_get a0)
  let get_pos_sib (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_pos_sib (Ptr.unsafe_get a0)
  let get_prefix66 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_prefix66 (Ptr.unsafe_get a0)
  let get_ptr (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_ptr (Ptr.unsafe_get a0)
  let get_realmode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_realmode (Ptr.unsafe_get a0)
  let get_reg (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_reg (Ptr.unsafe_get a0)
  let get_reg0 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg0 (Ptr.unsafe_get a0)
  let get_reg1 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg1 (Ptr.unsafe_get a0)
  let get_reg2 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg2 (Ptr.unsafe_get a0)
  let get_reg3 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg3 (Ptr.unsafe_get a0)
  let get_reg4 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg4 (Ptr.unsafe_get a0)
  let get_reg5 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg5 (Ptr.unsafe_get a0)
  let get_reg6 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg6 (Ptr.unsafe_get a0)
  let get_reg7 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg7 (Ptr.unsafe_get a0)
  let get_reg8 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg8 (Ptr.unsafe_get a0)
  let get_reg9 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_reg9 (Ptr.unsafe_get a0)
  let get_relbr (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_relbr (Ptr.unsafe_get a0)
  let get_rep (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rep (Ptr.unsafe_get a0)
  let get_rex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rex (Ptr.unsafe_get a0)
  let get_rexb (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rexb (Ptr.unsafe_get a0)
  let get_rexr (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rexr (Ptr.unsafe_get a0)
  let get_rexrr (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rexrr (Ptr.unsafe_get a0)
  let get_rexw (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rexw (Ptr.unsafe_get a0)
  let get_rexx (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rexx (Ptr.unsafe_get a0)
  let get_rm (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_rm (Ptr.unsafe_get a0)
  let get_roundc (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_roundc (Ptr.unsafe_get a0)
  let get_sae (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_sae (Ptr.unsafe_get a0)
  let get_scale (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_scale (Ptr.unsafe_get a0)
  let get_seg0 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_seg0 (Ptr.unsafe_get a0)
  let get_seg1 (a0 : [>`Read] Types.decoded_inst_ptr) : XBEnums.reg =
    Funcs.xed3_operand_get_seg1 (Ptr.unsafe_get a0)
  let get_seg_ovd (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_seg_ovd (Ptr.unsafe_get a0)
  let get_sibbase (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_sibbase (Ptr.unsafe_get a0)
  let get_sibindex (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_sibindex (Ptr.unsafe_get a0)
  let get_sibscale (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_sibscale (Ptr.unsafe_get a0)
  let get_smode (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_smode (Ptr.unsafe_get a0)
  let get_srm (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_srm (Ptr.unsafe_get a0)
  let get_tzcnt (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_tzcnt (Ptr.unsafe_get a0)
  let get_ubit (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_ubit (Ptr.unsafe_get a0)
  let get_uimm0 (a0 : [>`Read] Types.decoded_inst_ptr) : Unsigned.UInt64.t =
    Funcs.xed3_operand_get_uimm0 (Ptr.unsafe_get a0)
  let get_uimm1 (a0 : [>`Read] Types.decoded_inst_ptr) : char =
    Funcs.xed3_operand_get_uimm1 (Ptr.unsafe_get a0)
  let get_using_default_segment0 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_using_default_segment0 (Ptr.unsafe_get a0)
  let get_using_default_segment1 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_using_default_segment1 (Ptr.unsafe_get a0)
  let get_vex_c4 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vex_c4 (Ptr.unsafe_get a0)
  let get_vex_prefix (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vex_prefix (Ptr.unsafe_get a0)
  let get_vexdest210 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vexdest210 (Ptr.unsafe_get a0)
  let get_vexdest3 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vexdest3 (Ptr.unsafe_get a0)
  let get_vexdest4 (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vexdest4 (Ptr.unsafe_get a0)
  let get_vexvalid (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vexvalid (Ptr.unsafe_get a0)
  let get_vl (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_vl (Ptr.unsafe_get a0)
  let get_wbnoinvd (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_wbnoinvd (Ptr.unsafe_get a0)
  let get_zeroing (a0 : [>`Read] Types.decoded_inst_ptr) : int =
    Funcs.xed3_operand_get_zeroing (Ptr.unsafe_get a0)
  let set_agen (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_agen (Ptr.unsafe_get a0) a1
  let set_amd3dnow (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_amd3dnow (Ptr.unsafe_get a0) a1
  let set_asz (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_asz (Ptr.unsafe_get a0) a1
  let set_base0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_base0 (Ptr.unsafe_get a0) a1
  let set_base1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_base1 (Ptr.unsafe_get a0) a1
  let set_bcast (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_bcast (Ptr.unsafe_get a0) a1
  let set_bcrc (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_bcrc (Ptr.unsafe_get a0) a1
  let set_brdisp_width (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : char) : unit =
    Funcs.xed3_operand_set_brdisp_width (Ptr.unsafe_get a0) a1
  let set_cet (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_cet (Ptr.unsafe_get a0) a1
  let set_chip (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.chip) : unit =
    Funcs.xed3_operand_set_chip (Ptr.unsafe_get a0) a1
  let set_cldemote (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_cldemote (Ptr.unsafe_get a0) a1
  let set_default_seg (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_default_seg (Ptr.unsafe_get a0) a1
  let set_df32 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_df32 (Ptr.unsafe_get a0) a1
  let set_df64 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_df64 (Ptr.unsafe_get a0) a1
  let set_disp (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Signed.Int64.t) : unit =
    Funcs.xed3_operand_set_disp (Ptr.unsafe_get a0) a1
  let set_disp_width (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : char) : unit =
    Funcs.xed3_operand_set_disp_width (Ptr.unsafe_get a0) a1
  let set_dummy (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_dummy (Ptr.unsafe_get a0) a1
  let set_easz (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_easz (Ptr.unsafe_get a0) a1
  let set_element_size (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_element_size (Ptr.unsafe_get a0) a1
  let set_encode_force (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_encode_force (Ptr.unsafe_get a0) a1
  let set_encoder_preferred (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_encoder_preferred (Ptr.unsafe_get a0) a1
  let set_eosz (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_eosz (Ptr.unsafe_get a0) a1
  let set_error (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.error) : unit =
    Funcs.xed3_operand_set_error (Ptr.unsafe_get a0) a1
  let set_esrc (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_esrc (Ptr.unsafe_get a0) a1
  let set_first_f2f3 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_first_f2f3 (Ptr.unsafe_get a0) a1
  let set_has_modrm (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_has_modrm (Ptr.unsafe_get a0) a1
  let set_has_sib (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_has_sib (Ptr.unsafe_get a0) a1
  let set_hint (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_hint (Ptr.unsafe_get a0) a1
  let set_iclass (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.iclass) : unit =
    Funcs.xed3_operand_set_iclass (Ptr.unsafe_get a0) a1
  let set_ild_f2 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_ild_f2 (Ptr.unsafe_get a0) a1
  let set_ild_f3 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_ild_f3 (Ptr.unsafe_get a0) a1
  let set_ild_seg (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_ild_seg (Ptr.unsafe_get a0) a1
  let set_imm0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_imm0 (Ptr.unsafe_get a0) a1
  let set_imm0signed (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_imm0signed (Ptr.unsafe_get a0) a1
  let set_imm1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_imm1 (Ptr.unsafe_get a0) a1
  let set_imm1_bytes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_imm1_bytes (Ptr.unsafe_get a0) a1
  let set_imm_width (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : char) : unit =
    Funcs.xed3_operand_set_imm_width (Ptr.unsafe_get a0) a1
  let set_index (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_index (Ptr.unsafe_get a0) a1
  let set_last_f2f3 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_last_f2f3 (Ptr.unsafe_get a0) a1
  let set_llrc (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_llrc (Ptr.unsafe_get a0) a1
  let set_lock (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_lock (Ptr.unsafe_get a0) a1
  let set_lzcnt (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_lzcnt (Ptr.unsafe_get a0) a1
  let set_map (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_map (Ptr.unsafe_get a0) a1
  let set_mask (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mask (Ptr.unsafe_get a0) a1
  let set_max_bytes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_max_bytes (Ptr.unsafe_get a0) a1
  let set_mem0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mem0 (Ptr.unsafe_get a0) a1
  let set_mem1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mem1 (Ptr.unsafe_get a0) a1
  let set_mem_width (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Unsigned.UInt16.t) : unit =
    Funcs.xed3_operand_set_mem_width (Ptr.unsafe_get a0) a1
  let set_mod (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mod (Ptr.unsafe_get a0) a1
  let set_mode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mode (Ptr.unsafe_get a0) a1
  let set_mode_first_prefix (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mode_first_prefix (Ptr.unsafe_get a0) a1
  let set_mode_short_ud0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mode_short_ud0 (Ptr.unsafe_get a0) a1
  let set_modep5 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_modep5 (Ptr.unsafe_get a0) a1
  let set_modep55c (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_modep55c (Ptr.unsafe_get a0) a1
  let set_modrm_byte (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_modrm_byte (Ptr.unsafe_get a0) a1
  let set_mpxmode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_mpxmode (Ptr.unsafe_get a0) a1
  let set_must_use_evex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_must_use_evex (Ptr.unsafe_get a0) a1
  let set_need_memdisp (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_need_memdisp (Ptr.unsafe_get a0) a1
  let set_need_sib (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_need_sib (Ptr.unsafe_get a0) a1
  let set_needrex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_needrex (Ptr.unsafe_get a0) a1
  let set_nelem (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_nelem (Ptr.unsafe_get a0) a1
  let set_no_evex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_no_evex (Ptr.unsafe_get a0) a1
  let set_no_vex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_no_vex (Ptr.unsafe_get a0) a1
  let set_nominal_opcode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_nominal_opcode (Ptr.unsafe_get a0) a1
  let set_norex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_norex (Ptr.unsafe_get a0) a1
  let set_nprefixes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_nprefixes (Ptr.unsafe_get a0) a1
  let set_nrexes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_nrexes (Ptr.unsafe_get a0) a1
  let set_nseg_prefixes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_nseg_prefixes (Ptr.unsafe_get a0) a1
  let set_osz (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_osz (Ptr.unsafe_get a0) a1
  let set_out_of_bytes (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_out_of_bytes (Ptr.unsafe_get a0) a1
  let set_outreg (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_outreg (Ptr.unsafe_get a0) a1
  let set_p4 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_p4 (Ptr.unsafe_get a0) a1
  let set_pos_disp (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_disp (Ptr.unsafe_get a0) a1
  let set_pos_imm (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_imm (Ptr.unsafe_get a0) a1
  let set_pos_imm1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_imm1 (Ptr.unsafe_get a0) a1
  let set_pos_modrm (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_modrm (Ptr.unsafe_get a0) a1
  let set_pos_nominal_opcode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_nominal_opcode (Ptr.unsafe_get a0) a1
  let set_pos_sib (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_pos_sib (Ptr.unsafe_get a0) a1
  let set_prefix66 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_prefix66 (Ptr.unsafe_get a0) a1
  let set_ptr (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_ptr (Ptr.unsafe_get a0) a1
  let set_realmode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_realmode (Ptr.unsafe_get a0) a1
  let set_reg (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_reg (Ptr.unsafe_get a0) a1
  let set_reg0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg0 (Ptr.unsafe_get a0) a1
  let set_reg1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg1 (Ptr.unsafe_get a0) a1
  let set_reg2 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg2 (Ptr.unsafe_get a0) a1
  let set_reg3 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg3 (Ptr.unsafe_get a0) a1
  let set_reg4 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg4 (Ptr.unsafe_get a0) a1
  let set_reg5 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg5 (Ptr.unsafe_get a0) a1
  let set_reg6 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg6 (Ptr.unsafe_get a0) a1
  let set_reg7 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg7 (Ptr.unsafe_get a0) a1
  let set_reg8 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg8 (Ptr.unsafe_get a0) a1
  let set_reg9 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_reg9 (Ptr.unsafe_get a0) a1
  let set_relbr (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_relbr (Ptr.unsafe_get a0) a1
  let set_rep (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rep (Ptr.unsafe_get a0) a1
  let set_rex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rex (Ptr.unsafe_get a0) a1
  let set_rexb (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rexb (Ptr.unsafe_get a0) a1
  let set_rexr (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rexr (Ptr.unsafe_get a0) a1
  let set_rexrr (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rexrr (Ptr.unsafe_get a0) a1
  let set_rexw (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rexw (Ptr.unsafe_get a0) a1
  let set_rexx (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rexx (Ptr.unsafe_get a0) a1
  let set_rm (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_rm (Ptr.unsafe_get a0) a1
  let set_roundc (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_roundc (Ptr.unsafe_get a0) a1
  let set_sae (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_sae (Ptr.unsafe_get a0) a1
  let set_scale (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_scale (Ptr.unsafe_get a0) a1
  let set_seg0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_seg0 (Ptr.unsafe_get a0) a1
  let set_seg1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : XBEnums.reg) : unit =
    Funcs.xed3_operand_set_seg1 (Ptr.unsafe_get a0) a1
  let set_seg_ovd (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_seg_ovd (Ptr.unsafe_get a0) a1
  let set_sibbase (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_sibbase (Ptr.unsafe_get a0) a1
  let set_sibindex (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_sibindex (Ptr.unsafe_get a0) a1
  let set_sibscale (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_sibscale (Ptr.unsafe_get a0) a1
  let set_smode (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_smode (Ptr.unsafe_get a0) a1
  let set_srm (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_srm (Ptr.unsafe_get a0) a1
  let set_tzcnt (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_tzcnt (Ptr.unsafe_get a0) a1
  let set_ubit (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_ubit (Ptr.unsafe_get a0) a1
  let set_uimm0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : Unsigned.UInt64.t) : unit =
    Funcs.xed3_operand_set_uimm0 (Ptr.unsafe_get a0) a1
  let set_uimm1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : char) : unit =
    Funcs.xed3_operand_set_uimm1 (Ptr.unsafe_get a0) a1
  let set_using_default_segment0 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_using_default_segment0 (Ptr.unsafe_get a0) a1
  let set_using_default_segment1 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_using_default_segment1 (Ptr.unsafe_get a0) a1
  let set_vex_c4 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vex_c4 (Ptr.unsafe_get a0) a1
  let set_vex_prefix (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vex_prefix (Ptr.unsafe_get a0) a1
  let set_vexdest210 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vexdest210 (Ptr.unsafe_get a0) a1
  let set_vexdest3 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vexdest3 (Ptr.unsafe_get a0) a1
  let set_vexdest4 (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vexdest4 (Ptr.unsafe_get a0) a1
  let set_vexvalid (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vexvalid (Ptr.unsafe_get a0) a1
  let set_vl (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_vl (Ptr.unsafe_get a0) a1
  let set_wbnoinvd (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_wbnoinvd (Ptr.unsafe_get a0) a1
  let set_zeroing (a0 : [>`Read|`Write] Types.decoded_inst_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed3_operand_set_zeroing (Ptr.unsafe_get a0) a1
end

module OperandValues = struct
  type -'perm t = (Types.operand_values Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.operand_values
  let accesses_memory (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_accesses_memory (Ptr.unsafe_get a0)
  let branch_not_taken_hint (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_branch_not_taken_hint (Ptr.unsafe_get a0)
  let branch_taken_hint (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_branch_taken_hint (Ptr.unsafe_get a0)
  let cet_no_track (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_cet_no_track (Ptr.unsafe_get a0)
  let clear_rep (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_clear_rep (Ptr.unsafe_get a0)
  let dump (a0 : [>`Read] Types.operand_values_ptr) (a1 : bytes) : unit =
    Funcs.xed_operand_values_dump (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let get_atomic (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_get_atomic (Ptr.unsafe_get a0)
  let get_base_reg (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_base_reg (Ptr.unsafe_get a0) a1
  let get_branch_displacement_byte (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : char =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_branch_displacement_byte (Ptr.unsafe_get a0) a1
  let get_branch_displacement_int32 (a0 : [>`Read] Types.operand_values_ptr) : Signed.Int32.t =
    Funcs.xed_operand_values_get_branch_displacement_int32 (Ptr.unsafe_get a0)
  let get_branch_displacement_length (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_branch_displacement_length (Ptr.unsafe_get a0)
  let get_branch_displacement_length_bits (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_branch_displacement_length_bits (Ptr.unsafe_get a0)
  let get_displacement_for_memop (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_get_displacement_for_memop (Ptr.unsafe_get a0)
  let get_effective_address_width (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_effective_address_width (Ptr.unsafe_get a0)
  let get_effective_operand_width (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_effective_operand_width (Ptr.unsafe_get a0)
  let get_iclass (a0 : [>`Read] Types.operand_values_ptr) : XBEnums.iclass =
    Funcs.xed_operand_values_get_iclass (Ptr.unsafe_get a0)
  let get_immediate_byte (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : char =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_immediate_byte (Ptr.unsafe_get a0) a1
  let get_immediate_int64 (a0 : [>`Read] Types.operand_values_ptr) : Signed.Int64.t =
    Funcs.xed_operand_values_get_immediate_int64 (Ptr.unsafe_get a0)
  let get_immediate_is_signed (a0 : [>`Read] Types.operand_values_ptr) : int =
    Funcs.xed_operand_values_get_immediate_is_signed (Ptr.unsafe_get a0)
  let get_immediate_uint64 (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt64.t =
    Funcs.xed_operand_values_get_immediate_uint64 (Ptr.unsafe_get a0)
  let get_index_reg (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_index_reg (Ptr.unsafe_get a0) a1
  let get_long_mode (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_get_long_mode (Ptr.unsafe_get a0)
  let get_memory_displacement_byte (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : char =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_memory_displacement_byte (Ptr.unsafe_get a0) a1
  let get_memory_displacement_int64 (a0 : [>`Read] Types.operand_values_ptr) : Signed.Int64.t =
    Funcs.xed_operand_values_get_memory_displacement_int64 (Ptr.unsafe_get a0)
  let get_memory_displacement_int64_raw (a0 : [>`Read] Types.operand_values_ptr) : Signed.Int64.t =
    Funcs.xed_operand_values_get_memory_displacement_int64_raw (Ptr.unsafe_get a0)
  let get_memory_displacement_length (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_memory_displacement_length (Ptr.unsafe_get a0)
  let get_memory_displacement_length_bits (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_memory_displacement_length_bits (Ptr.unsafe_get a0)
  let get_memory_displacement_length_bits_raw (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_memory_displacement_length_bits_raw (Ptr.unsafe_get a0)
  let get_memory_operand_length (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : int =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_memory_operand_length (Ptr.unsafe_get a0) a1
  let get_pp_vex_prefix (a0 : [>`Read] Types.operand_values_ptr) : int =
    Funcs.xed_operand_values_get_pp_vex_prefix (Ptr.unsafe_get a0)
  let get_real_mode (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_get_real_mode (Ptr.unsafe_get a0)
  let get_scale (a0 : [>`Read] Types.operand_values_ptr) : int =
    Funcs.xed_operand_values_get_scale (Ptr.unsafe_get a0)
  let get_second_immediate (a0 : [>`Read] Types.operand_values_ptr) : char =
    Funcs.xed_operand_values_get_second_immediate (Ptr.unsafe_get a0)
  let get_seg_reg (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : XBEnums.reg =
    assert (a1 >= 0);
    Funcs.xed_operand_values_get_seg_reg (Ptr.unsafe_get a0) a1
  let get_stack_address_width (a0 : [>`Read] Types.operand_values_ptr) : Unsigned.UInt32.t =
    Funcs.xed_operand_values_get_stack_address_width (Ptr.unsafe_get a0)
  let has_66_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_66_prefix (Ptr.unsafe_get a0)
  let has_address_size_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_address_size_prefix (Ptr.unsafe_get a0)
  let has_branch_displacement (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_branch_displacement (Ptr.unsafe_get a0)
  let has_displacement (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_displacement (Ptr.unsafe_get a0)
  let has_immediate (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_immediate (Ptr.unsafe_get a0)
  let has_lock_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_lock_prefix (Ptr.unsafe_get a0)
  let has_memory_displacement (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_memory_displacement (Ptr.unsafe_get a0)
  let has_modrm_byte (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_modrm_byte (Ptr.unsafe_get a0)
  let has_operand_size_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_operand_size_prefix (Ptr.unsafe_get a0)
  let has_real_rep (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_real_rep (Ptr.unsafe_get a0)
  let has_rep_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_rep_prefix (Ptr.unsafe_get a0)
  let has_repne_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_repne_prefix (Ptr.unsafe_get a0)
  let has_rexw_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_rexw_prefix (Ptr.unsafe_get a0)
  let has_segment_prefix (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_segment_prefix (Ptr.unsafe_get a0)
  let has_sib_byte (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_has_sib_byte (Ptr.unsafe_get a0)
  let init () : [<`Read|`Write] t =
   let a0 = uninit () in
    Funcs.xed_operand_values_init (Ptr.get a0);
    a0
  let init_keep_mode (a1 : [>`Read] Types.operand_values_ptr) : [<`Read|`Write] t =
   let a0 = uninit () in
    Funcs.xed_operand_values_init_keep_mode (Ptr.get a0) (Ptr.unsafe_get a1);
    a0
  let init_set_mode (a1 : [>`Read] Types.state_ptr) : [<`Read|`Write] t =
   let a0 = uninit () in
    Funcs.xed_operand_values_init_set_mode (Ptr.get a0) (Ptr.unsafe_get a1);
    a0
  let is_nop (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_is_nop (Ptr.unsafe_get a0)
  let lockable (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_lockable (Ptr.unsafe_get a0)
  let memop_without_modrm (a0 : [>`Read] Types.operand_values_ptr) : bool =
    Funcs.xed_operand_values_memop_without_modrm (Ptr.unsafe_get a0)
  let number_of_memory_operands (a0 : [>`Read] Types.operand_values_ptr) : int =
    Funcs.xed_operand_values_number_of_memory_operands (Ptr.unsafe_get a0)
  let print_short (a0 : [>`Read] Types.operand_values_ptr) (a1 : bytes) : unit =
    Funcs.xed_operand_values_print_short (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let segment_prefix (a0 : [>`Read] Types.operand_values_ptr) : XBEnums.reg =
    Funcs.xed_operand_values_segment_prefix (Ptr.unsafe_get a0)
  let set_base_reg (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) (a2 : XBEnums.reg) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_base_reg (Ptr.unsafe_get a0) a1 a2
  let set_branch_displacement (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_branch_displacement (Ptr.unsafe_get a0) a1 a2
  let set_branch_displacement_bits (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_branch_displacement_bits (Ptr.unsafe_get a0) a1 a2
  let set_effective_address_width (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_effective_address_width (Ptr.unsafe_get a0) a1
  let set_effective_operand_width (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_effective_operand_width (Ptr.unsafe_get a0) a1
  let set_iclass (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : XBEnums.iclass) : unit =
    Funcs.xed_operand_values_set_iclass (Ptr.unsafe_get a0) a1
  let set_immediate_signed (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_immediate_signed (Ptr.unsafe_get a0) a1 a2
  let set_immediate_signed_bits (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int32.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_immediate_signed_bits (Ptr.unsafe_get a0) a1 a2
  let set_immediate_unsigned (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_immediate_unsigned (Ptr.unsafe_get a0) a1 a2
  let set_immediate_unsigned_bits (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Unsigned.UInt64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_immediate_unsigned_bits (Ptr.unsafe_get a0) a1 a2
  let set_index_reg (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) (a2 : XBEnums.reg) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_index_reg (Ptr.unsafe_get a0) a1 a2
  let set_lock (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_set_lock (Ptr.unsafe_get a0)
  let set_memory_displacement (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_memory_displacement (Ptr.unsafe_get a0) a1 a2
  let set_memory_displacement_bits (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : Signed.Int64.t) (a2 : int) : unit =
    assert (a2 >= 0);
    Funcs.xed_operand_values_set_memory_displacement_bits (Ptr.unsafe_get a0) a1 a2
  let set_memory_operand_length (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_memory_operand_length (Ptr.unsafe_get a0) a1
  let set_mode (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : [>`Read] Types.state_ptr) : unit =
    Funcs.xed_operand_values_set_mode (Ptr.unsafe_get a0) (Ptr.unsafe_get a1)
  let set_operand_reg (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : XBEnums.operand) (a2 : XBEnums.reg) : unit =
    Funcs.xed_operand_values_set_operand_reg (Ptr.unsafe_get a0) a1 a2
  let set_relbr (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_set_relbr (Ptr.unsafe_get a0)
  let set_scale (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) (a2 : int) : unit =
    assert (a1 >= 0 && a2 >= 0);
    Funcs.xed_operand_values_set_scale (Ptr.unsafe_get a0) a1 a2
  let set_seg_reg (a0 : [>`Read|`Write] Types.operand_values_ptr) (a1 : int) (a2 : XBEnums.reg) : unit =
    assert (a1 >= 0);
    Funcs.xed_operand_values_set_seg_reg (Ptr.unsafe_get a0) a1 a2
  let using_default_segment (a0 : [>`Read] Types.operand_values_ptr) (a1 : int) : bool =
    assert (a1 >= 0);
    Funcs.xed_operand_values_using_default_segment (Ptr.unsafe_get a0) a1
  let zero_branch_displacement (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_zero_branch_displacement (Ptr.unsafe_get a0)
  let zero_immediate (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_zero_immediate (Ptr.unsafe_get a0)
  let zero_memory_displacement (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_zero_memory_displacement (Ptr.unsafe_get a0)
  let zero_segment_override (a0 : [>`Read|`Write] Types.operand_values_ptr) : unit =
    Funcs.xed_operand_values_zero_segment_override (Ptr.unsafe_get a0)
end

module SimpleFlag = struct
  type -'perm t = (Types.simple_flag Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.simple_flag
  let get_flag_action (a0 : [>`Read] Types.simple_flag_ptr) (a1 : int) : [<`Read] Types.flag_action_ptr =
    assert (a1 >= 0);
    Funcs.xed_simple_flag_get_flag_action (Ptr.unsafe_get a0) a1 |> Ptr.ro
  let get_may_write (a0 : [>`Read] Types.simple_flag_ptr) : bool =
    Funcs.xed_simple_flag_get_may_write (Ptr.unsafe_get a0)
  let get_must_write (a0 : [>`Read] Types.simple_flag_ptr) : bool =
    Funcs.xed_simple_flag_get_must_write (Ptr.unsafe_get a0)
  let get_nflags (a0 : [>`Read] Types.simple_flag_ptr) : int =
    Funcs.xed_simple_flag_get_nflags (Ptr.unsafe_get a0)
  let get_read_flag_set (a0 : [>`Read] Types.simple_flag_ptr) : [<`Read] Types.flag_set_ptr =
    Funcs.xed_simple_flag_get_read_flag_set (Ptr.unsafe_get a0) |> Ptr.ro
  let get_undefined_flag_set (a0 : [>`Read] Types.simple_flag_ptr) : [<`Read] Types.flag_set_ptr =
    Funcs.xed_simple_flag_get_undefined_flag_set (Ptr.unsafe_get a0) |> Ptr.ro
  let get_written_flag_set (a0 : [>`Read] Types.simple_flag_ptr) : [<`Read] Types.flag_set_ptr =
    Funcs.xed_simple_flag_get_written_flag_set (Ptr.unsafe_get a0) |> Ptr.ro
  let print (a0 : [>`Read] Types.simple_flag_ptr) (a1 : bytes) : int =
    Funcs.xed_simple_flag_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let reads_flags (a0 : [>`Read] Types.simple_flag_ptr) : bool =
    Funcs.xed_simple_flag_reads_flags (Ptr.unsafe_get a0)
  let writes_flags (a0 : [>`Read] Types.simple_flag_ptr) : bool =
    Funcs.xed_simple_flag_writes_flags (Ptr.unsafe_get a0)
end

module State = struct
  type -'perm t = (Types.state Ctypes.abstract, 'perm) Ptr.t
  let uninit () = Ptr.rw @@ Ctypes.allocate_n ~count:1 Types.state
  let get_address_width (a0 : [>`Read] Types.state_ptr) : XBEnums.address_width =
    Funcs.xed_state_get_address_width (Ptr.unsafe_get a0)
  let get_machine_mode (a0 : [>`Read] Types.state_ptr) : XBEnums.machine_mode =
    Funcs.xed_state_get_machine_mode (Ptr.unsafe_get a0)
  let get_stack_address_width (a0 : [>`Read] Types.state_ptr) : XBEnums.address_width =
    Funcs.xed_state_get_stack_address_width (Ptr.unsafe_get a0)
  let init (a1 : XBEnums.machine_mode) (a2 : XBEnums.address_width) (a3 : XBEnums.address_width) : [<`Read|`Write] t =
   let a0 = uninit () in
    Funcs.xed_state_init (Ptr.get a0) a1 a2 a3;
    a0
  let init2 (a1 : XBEnums.machine_mode) (a2 : XBEnums.address_width) : [<`Read|`Write] t =
   let a0 = uninit () in
    Funcs.xed_state_init2 (Ptr.get a0) a1 a2;
    a0
  let long64_mode (a0 : [>`Read] Types.state_ptr) : bool =
    Funcs.xed_state_long64_mode (Ptr.unsafe_get a0)
  let mode_width_16 (a0 : [>`Read] Types.state_ptr) : bool =
    Funcs.xed_state_mode_width_16 (Ptr.unsafe_get a0)
  let mode_width_32 (a0 : [>`Read] Types.state_ptr) : bool =
    Funcs.xed_state_mode_width_32 (Ptr.unsafe_get a0)
  let print (a0 : [>`Read] Types.state_ptr) (a1 : bytes) : int =
    Funcs.xed_state_print (Ptr.unsafe_get a0) (Ctypes.ocaml_bytes_start a1) (Bytes.length a1)
  let real_mode (a0 : [>`Read] Types.state_ptr) : bool =
    Funcs.xed_state_real_mode (Ptr.unsafe_get a0)
  let set_machine_mode (a0 : [>`Read|`Write] Types.state_ptr) (a1 : XBEnums.machine_mode) : unit =
    Funcs.xed_state_set_machine_mode (Ptr.unsafe_get a0) a1
  let set_stack_address_width (a0 : [>`Read|`Write] Types.state_ptr) (a1 : XBEnums.address_width) : unit =
    Funcs.xed_state_set_stack_address_width (Ptr.unsafe_get a0) a1
  let zero (a0 : [>`Read|`Write] Types.state_ptr) : unit =
    Funcs.xed_state_zero (Ptr.unsafe_get a0)
end


module Constants = struct
  let enc_groups = 537
  let encode_fb_values_table_size = 4285
  let encode_max_emit_patterns = 200
  let encode_max_fb_patterns = 126
  let encode_max_iforms = 7733
  let encode_order_max_entries = 32
  let encode_order_max_operands = 5
  let encoder_operands_max = 8
  let feature_vector_max = 6
  let iclass_name_str_max = 142
  let max_attribute_count = 99
  let max_convert_patterns = 5
  let max_decorations_per_operand = 3
  let max_displacement_bytes = 8
  let max_global_flag_actions = 472
  let max_iforms_per_iclass = 26
  let max_immediate_bytes = 8
  let max_inst_table_nodes = 7706
  let max_instruction_bytes = 15
  let max_map_evex = 6
  let max_map_vex = 3
  let max_operand_sequences = 9059
  let max_operand_table_nodes = 1538
  let max_required_attributes = 211
  let max_required_complex_flags_entries = 37
  let max_required_simple_flags_entries = 99
end

module Enum = struct
  include XBEnums
  let address_width_of_string (a0 : string) : XBEnums.address_width =
    Funcs.str2xed_address_width_enum_t a0
  let address_width_to_string (a0 : XBEnums.address_width) : string =
    Funcs.xed_address_width_enum_t2str a0
  let attribute_of_string (a0 : string) : XBEnums.attribute =
    Funcs.str2xed_attribute_enum_t a0
  let attribute_to_string (a0 : XBEnums.attribute) : string =
    Funcs.xed_attribute_enum_t2str a0
  let category_of_string (a0 : string) : XBEnums.category =
    Funcs.str2xed_category_enum_t a0
  let category_to_string (a0 : XBEnums.category) : string =
    Funcs.xed_category_enum_t2str a0
  let chip_of_string (a0 : string) : XBEnums.chip =
    Funcs.str2xed_chip_enum_t a0
  let chip_to_string (a0 : XBEnums.chip) : string =
    Funcs.xed_chip_enum_t2str a0
  let cpuid_bit_of_string (a0 : string) : XBEnums.cpuid_bit =
    Funcs.str2xed_cpuid_bit_enum_t a0
  let cpuid_bit_to_string (a0 : XBEnums.cpuid_bit) : string =
    Funcs.xed_cpuid_bit_enum_t2str a0
  let error_of_string (a0 : string) : XBEnums.error =
    Funcs.str2xed_error_enum_t a0
  let error_to_string (a0 : XBEnums.error) : string =
    Funcs.xed_error_enum_t2str a0
  let exception_of_string (a0 : string) : XBEnums.iexception =
    Funcs.str2xed_exception_enum_t a0
  let exception_to_string (a0 : XBEnums.iexception) : string =
    Funcs.xed_exception_enum_t2str a0
  let extension_of_string (a0 : string) : XBEnums.extension =
    Funcs.str2xed_extension_enum_t a0
  let extension_to_string (a0 : XBEnums.extension) : string =
    Funcs.xed_extension_enum_t2str a0
  let flag_action_of_string (a0 : string) : XBEnums.flag_action =
    Funcs.str2xed_flag_action_enum_t a0
  let flag_action_to_string (a0 : XBEnums.flag_action) : string =
    Funcs.xed_flag_action_enum_t2str a0
  let flag_of_string (a0 : string) : XBEnums.flag =
    Funcs.str2xed_flag_enum_t a0
  let flag_to_string (a0 : XBEnums.flag) : string =
    Funcs.xed_flag_enum_t2str a0
  let iclass_of_string (a0 : string) : XBEnums.iclass =
    Funcs.str2xed_iclass_enum_t a0
  let iclass_to_string (a0 : XBEnums.iclass) : string =
    Funcs.xed_iclass_enum_t2str a0
  let iform_of_string (a0 : string) : XBEnums.iform =
    Funcs.str2xed_iform_enum_t a0
  let iform_to_string (a0 : XBEnums.iform) : string =
    Funcs.xed_iform_enum_t2str a0
  let isa_set_of_string (a0 : string) : XBEnums.isa_set =
    Funcs.str2xed_isa_set_enum_t a0
  let isa_set_to_string (a0 : XBEnums.isa_set) : string =
    Funcs.xed_isa_set_enum_t2str a0
  let machine_mode_of_string (a0 : string) : XBEnums.machine_mode =
    Funcs.str2xed_machine_mode_enum_t a0
  let machine_mode_to_string (a0 : XBEnums.machine_mode) : string =
    Funcs.xed_machine_mode_enum_t2str a0
  let nonterminal_of_string (a0 : string) : XBEnums.nonterminal =
    Funcs.str2xed_nonterminal_enum_t a0
  let nonterminal_to_string (a0 : XBEnums.nonterminal) : string =
    Funcs.xed_nonterminal_enum_t2str a0
  let operand_action_of_string (a0 : string) : XBEnums.operand_action =
    Funcs.str2xed_operand_action_enum_t a0
  let operand_action_to_string (a0 : XBEnums.operand_action) : string =
    Funcs.xed_operand_action_enum_t2str a0
  let operand_convert_of_string (a0 : string) : XBEnums.operand_convert =
    Funcs.str2xed_operand_convert_enum_t a0
  let operand_convert_to_string (a0 : XBEnums.operand_convert) : string =
    Funcs.xed_operand_convert_enum_t2str a0
  let operand_element_type_of_string (a0 : string) : XBEnums.operand_element_type =
    Funcs.str2xed_operand_element_type_enum_t a0
  let operand_element_type_to_string (a0 : XBEnums.operand_element_type) : string =
    Funcs.xed_operand_element_type_enum_t2str a0
  let operand_element_xtype_of_string (a0 : string) : XBEnums.operand_element_xtype =
    Funcs.str2xed_operand_element_xtype_enum_t a0
  let operand_element_xtype_to_string (a0 : XBEnums.operand_element_xtype) : string =
    Funcs.xed_operand_element_xtype_enum_t2str a0
  let operand_of_string (a0 : string) : XBEnums.operand =
    Funcs.str2xed_operand_enum_t a0
  let operand_to_string (a0 : XBEnums.operand) : string =
    Funcs.xed_operand_enum_t2str a0
  let operand_type_of_string (a0 : string) : XBEnums.operand_type =
    Funcs.str2xed_operand_type_enum_t a0
  let operand_type_to_string (a0 : XBEnums.operand_type) : string =
    Funcs.xed_operand_type_enum_t2str a0
  let operand_visibility_of_string (a0 : string) : XBEnums.operand_visibility =
    Funcs.str2xed_operand_visibility_enum_t a0
  let operand_visibility_to_string (a0 : XBEnums.operand_visibility) : string =
    Funcs.xed_operand_visibility_enum_t2str a0
  let operand_width_of_string (a0 : string) : XBEnums.operand_width =
    Funcs.str2xed_operand_width_enum_t a0
  let operand_width_to_string (a0 : XBEnums.operand_width) : string =
    Funcs.xed_operand_width_enum_t2str a0
  let reg_class_of_string (a0 : string) : XBEnums.reg_class =
    Funcs.str2xed_reg_class_enum_t a0
  let reg_class_to_string (a0 : XBEnums.reg_class) : string =
    Funcs.xed_reg_class_enum_t2str a0
  let reg_of_string (a0 : string) : XBEnums.reg =
    Funcs.str2xed_reg_enum_t a0
  let reg_to_string (a0 : XBEnums.reg) : string =
    Funcs.xed_reg_enum_t2str a0
  let syntax_of_string (a0 : string) : XBEnums.syntax =
    Funcs.str2xed_syntax_enum_t a0
  let syntax_to_string (a0 : XBEnums.syntax) : string =
    Funcs.xed_syntax_enum_t2str a0
  let cpuid_bit_for_isa_set (a0 : XBEnums.isa_set) (a1 : int) : XBEnums.cpuid_bit =
    assert (a1 >= 0);
    Funcs.xed_get_cpuid_bit_for_isa_set a0 a1
  let flag_action_action_invalid (a0 : XBEnums.flag_action) : bool =
    Funcs.xed_flag_action_action_invalid a0
  let flag_action_read_action (a0 : XBEnums.flag_action) : bool =
    Funcs.xed_flag_action_read_action a0
  let flag_action_write_action (a0 : XBEnums.flag_action) : bool =
    Funcs.xed_flag_action_write_action a0
  let gpr_reg_class (a0 : XBEnums.reg) : XBEnums.reg_class =
    Funcs.xed_gpr_reg_class a0
  let iclass_norep_map (a0 : XBEnums.iclass) : XBEnums.iclass =
    Funcs.xed_norep_map a0
  let iclass_rep_map (a0 : XBEnums.iclass) : XBEnums.iclass =
    Funcs.xed_rep_map a0
  let iclass_rep_remove (a0 : XBEnums.iclass) : XBEnums.iclass =
    Funcs.xed_rep_remove a0
  let iclass_repe_map (a0 : XBEnums.iclass) : XBEnums.iclass =
    Funcs.xed_repe_map a0
  let iclass_repne_map (a0 : XBEnums.iclass) : XBEnums.iclass =
    Funcs.xed_repne_map a0
  let iform_first_per_iclass (a0 : XBEnums.iclass) : Unsigned.UInt32.t =
    Funcs.xed_iform_first_per_iclass a0
  let iform_max_per_iclass (a0 : XBEnums.iclass) : Unsigned.UInt32.t =
    Funcs.xed_iform_max_per_iclass a0
  let iform_to_category (a0 : XBEnums.iform) : XBEnums.category =
    Funcs.xed_iform_to_category a0
  let iform_to_extension (a0 : XBEnums.iform) : XBEnums.extension =
    Funcs.xed_iform_to_extension a0
  let iform_to_iclass (a0 : XBEnums.iform) : XBEnums.iclass =
    Funcs.xed_iform_to_iclass a0
  let iform_to_iclass_string_att (a0 : XBEnums.iform) : string =
    Funcs.xed_iform_to_iclass_string_att a0
  let iform_to_iclass_string_intel (a0 : XBEnums.iform) : string =
    Funcs.xed_iform_to_iclass_string_intel a0
  let iform_to_isa_set (a0 : XBEnums.iform) : XBEnums.isa_set =
    Funcs.xed_iform_to_isa_set a0
  let isa_set_is_valid_for_chip (a0 : XBEnums.isa_set) (a1 : XBEnums.chip) : bool =
    Funcs.xed_isa_set_is_valid_for_chip a0 a1
  let largest_enclosing_register (a0 : XBEnums.reg) : XBEnums.reg =
    Funcs.xed_get_largest_enclosing_register a0
  let largest_enclosing_register32 (a0 : XBEnums.reg) : XBEnums.reg =
    Funcs.xed_get_largest_enclosing_register32 a0
  let operand_action_conditional_read (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_conditional_read a0
  let operand_action_conditional_write (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_conditional_write a0
  let operand_action_read (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_read a0
  let operand_action_read_and_written (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_read_and_written a0
  let operand_action_read_only (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_read_only a0
  let operand_action_written (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_written a0
  let operand_action_written_only (a0 : XBEnums.operand_action) : int =
    Funcs.xed_operand_action_written_only a0
  let operand_is_memory_addressing_register (a0 : XBEnums.operand) : int =
    Funcs.xed_operand_is_memory_addressing_register a0
  let operand_is_register (a0 : XBEnums.operand) : int =
    Funcs.xed_operand_is_register a0
  let reg_class (a0 : XBEnums.reg) : XBEnums.reg_class =
    Funcs.xed_reg_class a0
  let register_width_bits (a0 : XBEnums.reg) : Unsigned.UInt32.t =
    Funcs.xed_get_register_width_bits a0
  let register_width_bits64 (a0 : XBEnums.reg) : Unsigned.UInt32.t =
    Funcs.xed_get_register_width_bits64 a0
end

module Enc = struct
end

(* other *)
let xed_attribute (a0 : int) : XBEnums.attribute =
  assert (a0 >= 0);
  Funcs.xed_attribute a0
let xed_attribute_max () : int =
  Funcs.xed_attribute_max ()
let xed_encode_nop (a0 : bytes) : XBEnums.error =
  Funcs.xed_encode_nop (Ctypes.ocaml_bytes_start a0) (Bytes.length a0)
let xed_get_copyright () : string =
  Funcs.xed_get_copyright ()
let xed_get_version () : string =
  Funcs.xed_get_version ()
let xed_set_verbosity (a0 : int) : unit =
  Funcs.xed_set_verbosity a0
let xed_tables_init () : unit =
  Funcs.xed_tables_init ()
