let () = Bind.xed_tables_init ()
include Bind.Constants
module Ptr = Bind.Ptr
let string_of_c x = Bytes.sub_string x 0 (try Bytes.index x '\x00' with Not_found -> Bytes.length x)

module Enum = struct
  include Bind.Enum
  let operand_action_read x = operand_action_read x <> 0
  let operand_action_read_only x = operand_action_read_only x <> 0
  let operand_action_written x = operand_action_written x <> 0
  let operand_action_written_only x = operand_action_written_only x <> 0
  let operand_action_read_and_written x = operand_action_read_and_written x <> 0
  let operand_action_conditional_read x = operand_action_conditional_read x <> 0
  let operand_action_conditional_write x = operand_action_conditional_write x <> 0

  let register_width_bits x = register_width_bits x |> Unsigned.UInt32.to_int
  let register_width_bits64 x = register_width_bits64 x |> Unsigned.UInt32.to_int

  let iform_max_per_iclass x = iform_max_per_iclass x |> Unsigned.UInt32.to_int
  let iform_first_per_iclass x = iform_first_per_iclass x |> Unsigned.UInt32.to_int

  let attributes =
    Array.init (Bind.xed_attribute_max ()) Bind.xed_attribute
end


module ChipFeatures = struct
  include Bind.ChipFeatures
end

module DecodedInst = struct
  include Bind.DecodedInst
  external _decoded_inst_get_attributes : nativeint -> Enum.attribute list = "xb_decoded_inst_get_attributes"
  let get_attributes x : Enum.attribute list =
    _decoded_inst_get_attributes @@ Ptr.raw_address x

  let init mode =
    let x = uninit ()
    in zero_set_mode x mode; x
  let to_string x =
    let bytes = Bytes.create 1024
    in dump x bytes; string_of_c bytes
  let to_string_xedfmt x addr =
    let bytes = Bytes.create 1024
    in dump_xed_format x bytes addr, string_of_c bytes

  (* Disable get_byte because it's a use-after-free and you get random heap bytes.
   * (A xed_decoded_inst_t only keeps the pointer passed to xed_decode, not the
   * actual input bytes. Luckily, no other decoded-inst-api methods use it.) *)
  let get_byte = ()
  (* let get_bytes x =
    String.init (get_length x) (get_byte x) *)

  external _disassemble : int -> nativeint -> int64 -> string = "xb_disassemble"
  let disassemble x syntax addr =
    _disassemble (Enum.syntax_to_int syntax) (Ptr.raw_address x) addr

  let to_string_intel x =
    disassemble x Enum.INTEL 0L
end

module EncoderInstruction = struct
  include Bind.EncoderInstruction
  (* external _xed_inst : nativeint -> nativeint -> int -> int -> int -> nativeint -> unit = "xb_xed_inst"
  let init state iclass effective_operand_width operands =
    assert (effective_operand_width >= 0);

    let f (operand : XedBindingsStubs.encoder_operand) : nativeint =
      let dat = Ctypes.getf (Obj.magic operand) XedBindingsStubs.enc_displacement_struct_dat in
      Ctypes.CArray.start dat |> Ctypes.raw_address_of_ptr
    in
    let carr = Ctypes.CArray.of_list @@ List.map f operands in
    let length = Ctypes.CArray.length carr in
    assert (length <= XedBindingsConstants.encoder_operands_max);
    let x = uninit () in
    _xed_inst
      (Ptr.raw_address x)
      (Ptr.raw_address state)
      (Enum.iclass_to_int iclass)
      effective_operand_width
      length
      (Ctypes.CArray.start carr |> Ctypes.raw_address_of_ptr)
    ; x *)
end

module EncoderRequest = struct
  include Bind.EncoderRequest
  external _encode : nativeint -> (int * string) = "xb_encode"
  let encode x =
    let err, dat = _encode @@ Ptr.raw_address x in
    match Enum.error_of_int err with
    | Enum.NONE -> Ok dat
    | err -> Error err

  let init mode =
    let x = uninit ()
    in zero_set_mode x mode; x

  let of_encoder_instruction (y : [>`Read] Bind.EncoderInstruction.t) =
    let x = uninit () in
    if convert_to_encoder_request x y then Some x else None

  external _init_from_decode : nativeint -> nativeint -> unit = "xb_encoder_request_init_from_decode"
  let of_decoded_inst (y : [>`Read] Bind.DecodedInst.t) =
    let x = uninit ()
    in _init_from_decode (Ptr.raw_address x) (Ptr.raw_address y); x

  let to_string x =
    let bytes = Bytes.create 5000 in
    print x bytes;
    match Bytes.index_opt bytes '\000' with
    | Some i -> Bytes.sub_string bytes 0 i
    | None -> Bytes.unsafe_to_string bytes
end

module FlagAction = struct
  include Bind.FlagAction
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module FlagSet = struct
  include Bind.FlagSet
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Inst = struct
  include Bind.Inst
  external _inst_get_attributes : nativeint -> Enum.attribute list = "xb_inst_get_attributes"
  let get_attributes x : Enum.attribute list =
    _inst_get_attributes (Ptr.raw_address x)
end

module Operand = struct
  include Bind.Operand
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes; string_of_c bytes
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
  include Bind.Operand3
end

module OperandValues = struct
  include Bind.OperandValues
  let to_string x =
    let bytes = Bytes.create 128
    in dump x bytes; string_of_c bytes
  let to_string_short x =
    let bytes = Bytes.create 128
    in print_short x bytes; string_of_c bytes
end

module SimpleFlag = struct
  include Bind.SimpleFlag
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module State = struct
  include Bind.State
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Enc = struct
  include Bind.Enc
end

let state32 = State.init2 Enum.LEGACY_32 Enum.A32b |> Ptr.const
let state64 = State.init2 Enum.LONG_64 Enum.A64b |> Ptr.const

let decode state s =
  let x = DecodedInst.init state in
  match Bind.DecodedInst.decode x s with
  | Enum.NONE -> Ok x
  | err -> Error err

let decode_with_features state s chipfeat =
  let x = DecodedInst.init state in
  match Bind.DecodedInst.decode_with_features x s chipfeat with
  | Enum.NONE -> Ok x
  | err -> Error err

let ild_decode state s =
  let x = DecodedInst.init state in
  match Bind.DecodedInst.ild_decode x s with
  | Enum.NONE -> Ok x
  | err -> Error err

let encode_nop len =
  let bytes = Bytes.create len in
  match Bind.xed_encode_nop bytes with
  | Enum.NONE -> Ok bytes
  | err -> Error err

let get_copyright = Bind.xed_get_copyright
let get_version = Bind.xed_get_version
let set_verbosity = Bind.xed_set_verbosity

let ok_err = function Ok x -> x | Error e -> failwith (Enum.error_to_string e)
