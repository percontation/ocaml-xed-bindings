(* This binding isn't entirely safe; e.g. `Inst.operand x 9999999` is bad. *)

let cstring x = Bytes.sub_string x 0 (try Bytes.index x '\x00' with Not_found -> Bytes.length x)

module ChipFeatures = struct
  include XedBindingsInternal.ChipFeatures
end

module DecodedInst = struct
  include XedBindingsInternal.DecodedInst
  let init mode =
    let x = allocate ()
    in zero_set_mode x mode; x
  let to_string x =
    let bytes = Bytes.create 1024
    in dump x bytes; cstring bytes
  let to_string_xedfmt x addr =
    let bytes = Bytes.create 1024
    in dump_xed_format x bytes addr, cstring bytes

  external _disassemble : int -> nativeint -> int64 -> string = "xb_disassemble"
  let disassemble x syntax addr =
    _disassemble (XedBindingsInternal.Enum.syntax_to_int syntax) (const_pointer x |> Ctypes.raw_address_of_ptr) addr
end

module EncoderRequest = struct
  include XedBindingsInternal.EncoderRequest
end

module FlagAction = struct
  include XedBindingsInternal.FlagAction
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module FlagSet = struct
  include XedBindingsInternal.FlagSet
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Inst = struct
  include XedBindingsInternal.Inst
end

module Operand = struct
  include XedBindingsInternal.Operand
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes; cstring bytes
  let read x = read x <> 0
  let read_only x = read_only x <> 0
  let written x = written x <> 0
  let written_only x = written_only x <> 0
  let read_and_written x = read_and_written x <> 0
  let conditional_read x = conditional_read x <> 0
  let conditional_write x = conditional_write x <> 0
  let template_is_register x = template_is_register x <> 0
end

module Operand3 = struct
  include XedBindingsInternal.Operand3
end

module OperandValues = struct
  include XedBindingsInternal.OperandValues
  let to_string x =
    let bytes = Bytes.create 128
    in dump x bytes; cstring bytes
  let to_string_short x =
    let bytes = Bytes.create 128
    in print_short x bytes; cstring bytes
end

module SimpleFlag = struct
  include XedBindingsInternal.SimpleFlag
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module State = struct
  include XedBindingsInternal.State
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Enum = struct
  open XedBindingsInternal
  include Enum
  let operand_is_register = xed_operand_is_register
  let operand_is_memory_addressing_register = xed_operand_is_memory_addressing_register
  let operand_action_read x = xed_operand_action_read x <> 0
  let operand_action_read_only x = xed_operand_action_read_only x <> 0
  let operand_action_written x = xed_operand_action_written x <> 0
  let operand_action_written_only x = xed_operand_action_written_only x <> 0
  let operand_action_read_and_written x = xed_operand_action_read_and_written x <> 0
  let operand_action_conditional_read x = xed_operand_action_conditional_read x <> 0
  let operand_action_conditional_write x = xed_operand_action_conditional_write x <> 0

  let reg_class = xed_reg_class
  let gpr_reg_class = xed_gpr_reg_class
  let largest_enclosing_reg = xed_get_largest_enclosing_register
  let largest_enclosing_reg32 = xed_get_largest_enclosing_register32
  let reg_width_bits x = xed_get_register_width_bits x |> Unsigned.UInt32.to_int
  let reg_width_bits64 x = xed_get_register_width_bits64 x |> Unsigned.UInt32.to_int

  let iclass_rep_remove = xed_rep_remove
  let iclass_repe_map = xed_repe_map
  let iclass_repne_map = xed_repne_map
  let iclass_rep_map = xed_rep_map
  let iclass_norep_map = xed_norep_map

  let iform_max_per_iclass x = xed_iform_max_per_iclass x |> Unsigned.UInt32.to_int
  let iform_first_per_iclass x = xed_iform_first_per_iclass x |> Unsigned.UInt32.to_int
  let iform_to_iclass = xed_iform_to_iclass
  let iform_to_category = xed_iform_to_category
  let iform_to_extension = xed_iform_to_extension
  let iform_to_isa_set = xed_iform_to_isa_set
  let iform_to_iclass_string_att = xed_iform_to_iclass_string_att
  let iform_to_iclass_string_intel = xed_iform_to_iclass_string_intel

  let flag_action_action_invalid = xed_flag_action_action_invalid
  let flag_action_read_action = xed_flag_action_read_action
  let flag_action_write_action = xed_flag_action_write_action

  let attributes = Array.init (xed_attribute_max ()) xed_attribute
end

let () = XedBindingsInternal.xed_tables_init ()

open Enum
let state32 = State.init2 LEGACY_32 A32b |> XedBindingsStructs.const
let state64 = State.init2 LONG_64 A64b |> XedBindingsStructs.const

let decode state s =
  let x = DecodedInst.init state in
  match XedBindingsInternal.xed_decode x s with
  | Enum.NONE -> Ok x
  | err -> Error err

let decode_with_features state s chipfeat =
  let x = DecodedInst.init state in
  match XedBindingsInternal.xed_decode_with_features x s chipfeat with
  | Enum.NONE -> Ok x
  | err -> Error err

let ild_decode state s =
  let x = DecodedInst.init state in
  match XedBindingsInternal.xed_ild_decode x s with
  | Enum.NONE -> Ok x
  | err -> Error err

let get_version = XedBindingsInternal.xed_get_version
let get_copyright = XedBindingsInternal.xed_get_copyright
let get_cpuid_bit_for_isa_set = XedBindingsInternal.xed_get_cpuid_bit_for_isa_set
