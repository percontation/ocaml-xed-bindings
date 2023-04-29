module Bind = Xedbindings_bind.Bind
let () = Bind.xed_tables_init ()
include Bind.Constants
module Ptr = Bind.Ptr

let string_of_c x =
  let eos = (try Bytes.index x '\x00' with Not_found -> Bytes.length x)
  in Bytes.sub_string x 0 eos

module Enum = struct
  include Bind.Enum

  open struct
    external _get_cpuid_rec: int -> int * int * int * int = "xb_get_cpuid_rec"
  end

  let operand_action_read x = operand_action_read x <> 0
  let operand_action_read_only x = operand_action_read_only x <> 0
  let operand_action_written x = operand_action_written x <> 0
  let operand_action_written_only x = operand_action_written_only x <> 0
  let operand_action_read_and_written x = operand_action_read_and_written x <> 0
  let operand_action_conditional_read x = operand_action_conditional_read x <> 0
  let operand_action_conditional_write x = operand_action_conditional_write x <> 0
  let operand_is_register x = operand_is_register x <> 0
  let operand_is_memory_addressing_register x = operand_is_memory_addressing_register x <> 0

  let register_width_bits x = register_width_bits x |> Unsigned.UInt32.to_int
  let register_width_bits64 x = register_width_bits64 x |> Unsigned.UInt32.to_int

  let iform_max_per_iclass x = iform_max_per_iclass x |> Unsigned.UInt32.to_int
  let iform_first_per_iclass x = iform_first_per_iclass x |> Unsigned.UInt32.to_int

  let attributes =
    Array.init (Bind.xed_attribute_max ()) Bind.xed_attribute

  type cpuid_bit_rec = {
    leaf: int;
    subleaf: int;
    reg: reg;
    bit: int;
  }
  let cpuid_bit_rec x =
    let leaf, subleaf, reg, bit = _get_cpuid_rec @@ cpuid_bit_to_int x
    in {leaf; subleaf; reg=reg_of_int reg; bit}

  let cpuid_bit_of_isa_set = cpuid_bit_for_isa_set
end


module ChipFeatures = struct
  include Bind.ChipFeatures
  let of_chip chip =
    let x = uninit ()
    in get_chip_features x chip; x
  let add x isa =
    modify_chip_features x isa true
  let remove x isa =
    modify_chip_features x isa false
end

module DecodedInst = struct
  include Bind.DecodedInst

  open struct
    external _decoded_inst_get_attributes
      : nativeint -> Enum.attribute list = "xb_decoded_inst_get_attributes"
    type symbolizer = (int64 -> (string * int64) option) option
    external _format
      : int -> nativeint -> int64 -> int -> symbolizer -> string = "xb_format"
  end

  let get_attributes (x: [>`Read] t) : Enum.attribute list =
    _decoded_inst_get_attributes @@ Ptr.raw_address x

  let init mode =
    let x = uninit ()
    in zero_set_mode x mode; x
  let dump x =
    let bytes = Bytes.create 4000
    in dump x bytes; string_of_c bytes
  let dump_xed_format x addr =
    let bytes = Bytes.create 1000 in
    match dump_xed_format x bytes addr with
    | true -> string_of_c bytes
    | false -> failwith "xed_decoded_inst_dump_xed_format"

  (** As with the XED C library, running this more than once without using one
      of the `zero_` functions first will result in an error.
      Note that for basic usage, you can (and should) use Xed.decode to both
      `init` & `decode` at the same time.
    *)
  let decode x ?features s =
    begin match features with
    | None -> Bind.xed_decode x s
    | Some f -> Bind.xed_decode_with_features x s f
    end |> function
    | Enum.NONE -> Ok x
    | err -> Error err

  let ild_decode x s =
    match Bind.xed_ild_decode x s with
    | Enum.NONE -> Ok x
    | err -> Error err

  (* Disable get_byte because it's a use-after-free and you get random heap bytes.
   * (A xed_decoded_inst_t only keeps the pointer passed to xed_decode, not the
   * actual input bytes. Luckily, no other decoded-inst-api methods use it.) *)
  let get_byte = ()
  (* let get_bytes x =
    String.init (get_length x) (get_byte x) *)

  let get_attribute x y = get_attribute x y <> Unsigned.UInt32.zero
  let get_immediate_is_signed x = get_immediate_is_signed x <> 0
  let has_mpx_prefix x = has_mpx_prefix x <> Unsigned.UInt32.zero
  let is_xacquire x = is_xacquire x <> Unsigned.UInt32.zero
  let is_xrelease x = is_xrelease x <> Unsigned.UInt32.zero
  let get_operand_width x = get_operand_width x |> Unsigned.UInt32.to_int

  (**
    @param symbolizer callback function to turn an address into a name & offset.
  *)
  let format
    ?(address_with_names=true)
    ?(xml_a=false)
    ?(xml_f=false)
    ?(omit_unit_scale=false)
    ?(no_ext_signed_imm=false)
    ?(curly_mask_omit_k0=true)
    ?(lowercase_hex=true)
    ?(positive_mem_disp=false)
    ?(syntax=Enum.INTEL)
    ?(symbolizer: symbolizer)
    (x: [>`Read] t) addr =
    let options = 0
      lor (if address_with_names then 1 lsl 0 else 0)
      lor (if xml_a              then 1 lsl 1 else 0)
      lor (if xml_f              then 1 lsl 2 else 0)
      lor (if omit_unit_scale    then 1 lsl 3 else 0)
      lor (if no_ext_signed_imm  then 1 lsl 4 else 0)
      lor (if curly_mask_omit_k0 then 1 lsl 5 else 0)
      lor (if lowercase_hex      then 1 lsl 6 else 0)
      lor (if positive_mem_disp  then 1 lsl 7 else 0)
    in
    _format (Enum.syntax_to_int syntax) (Ptr.raw_address x) addr options symbolizer

  (**
    It's undefined exactly what format you get from to_string.
    Currently, it assumes address 0 and formats in intel syntax.
  *)
  let to_string x =
    format x 0L

end

module EncoderRequest = struct
  include Bind.EncoderRequest

  open struct
    external _encode : nativeint -> (int * string) = "xb_encode"
    external _init_from_decode : nativeint -> nativeint -> unit = "xb_encoder_request_init_from_decode"
  end

  let encode (x: [>`Read] t) =
    let err, dat = _encode @@ Ptr.raw_address x in
    match Enum.error_of_int err with
    | Enum.NONE -> Ok dat
    | err -> Error err

  let init mode =
    let x = uninit ()
    in zero_set_mode x mode; x

  let of_decoded_inst (y : [>`Read] Bind.DecodedInst.t) =
    let x = uninit ()
    in _init_from_decode (Ptr.raw_address x) (Ptr.raw_address y); x

  let to_string x =
    let bytes = Bytes.create 5000 in
    Bind.xed_encode_request_print x bytes;
    match Bytes.index_opt bytes '\000' with
    | Some i -> Bytes.sub_string bytes 0 i
    | None -> Bytes.unsafe_to_string bytes
end

module FlagAction = struct
  include Bind.FlagAction
  let to_string x =
    let bytes = Bytes.create 100
    in print x bytes |> Bytes.sub_string bytes 0
end

module FlagSet = struct
  include Bind.FlagSet
  let to_string x =
    let bytes = Bytes.create 100
    in print x bytes |> Bytes.sub_string bytes 0
end

module Inst = struct
  include Bind.Inst

  open struct
    external _inst_get_attributes : nativeint -> Enum.attribute list = "xb_inst_get_attributes"
  end

  let get_attributes (x: [>`Read] t) : Enum.attribute list =
    _inst_get_attributes (Ptr.raw_address x)
  let get_attribute x y = get_attribute x y <> Unsigned.UInt32.zero
  let flag_info_index x = flag_info_index x |> Unsigned.UInt32.to_int

  let fold_left_operands inst ~init ~f =
    let acc = ref init in
    for i = 0 to noperands inst - 1 do
      acc := f i !acc @@ operand inst i
    done;
    !acc

  let fold_right_operands inst ~f ~init =
    let acc = ref init in
    for i = noperands inst - 1 downto 0 do
      acc := f i (operand inst i) !acc
    done;
    !acc
end

module Operand = struct
  include Bind.Operand
  let to_string x =
    let bytes = Bytes.create 100
    in print x bytes; string_of_c bytes
  let read x = read x <> 0
  let read_only x = read_only x <> 0
  let written x = written x <> 0
  let written_only x = written_only x <> 0
  let read_and_written x = read_and_written x <> 0
  let conditional_read x = conditional_read x <> 0
  let conditional_write x = conditional_write x <> 0
  let template_is_register x = template_is_register x <> 0
  let width_bits x eosz =
    let eosz = match eosz with
      | `B16 -> 1
      | `B32 -> 2
      | `B64 -> 3
    in width_bits x (Unsigned.UInt32.of_int eosz) |> Unsigned.UInt32.to_int
end

module Operand3 = struct
  include Bind.Operand3
  let get_has_modrm x = get_has_modrm x <> 0
  let set_has_modrm x b = set_has_modrm x (if b then 1 else 0)
  let get_has_sib x = get_has_sib x <> 0
  let set_has_sib x b = set_has_sib x (if b then 1 else 0)
end

module OperandValues = struct
  include Bind.OperandValues
  let dump x =
    let bytes = Bytes.create 100
    in dump x bytes; string_of_c bytes
  let to_string x =
    let bytes = Bytes.create 100
    in print_short x bytes; string_of_c bytes

  let get_immediate_is_signed x = get_immediate_is_signed x <> 0
  let get_branch_displacement_length x = get_branch_displacement_length x |> Unsigned.UInt32.to_int
  let get_branch_displacement_length_bits x = get_branch_displacement_length_bits x |> Unsigned.UInt32.to_int
  let get_effective_address_width x = get_effective_address_width x |> Unsigned.UInt32.to_int
  let get_effective_operand_width x = get_effective_operand_width x |> Unsigned.UInt32.to_int
  let get_memory_displacement_length x = get_memory_displacement_length x |> Unsigned.UInt32.to_int
  let get_memory_displacement_length_bits x = get_memory_displacement_length_bits x |> Unsigned.UInt32.to_int
  let get_memory_displacement_length_bits_raw x = get_memory_displacement_length_bits_raw x |> Unsigned.UInt32.to_int
  let get_stack_address_width x = get_stack_address_width x |> Unsigned.UInt32.to_int
end

module SimpleFlag = struct
  include Bind.SimpleFlag
  let to_string x =
    let bytes = Bytes.create 100
    in print x bytes |> Bytes.sub_string bytes 0
end

module State = struct
  include Bind.State
  let to_string x =
    let bytes = Bytes.create 100
    in print x bytes |> Bytes.sub_string bytes 0
end

module Enc = struct
  include Bind.Enc
end

let state32 = State.init2 Enum.LEGACY_32 Enum.A32b |> Ptr.const
let state64 = State.init2 Enum.LONG_64 Enum.A64b |> Ptr.const

let decode state ?features s =
  DecodedInst.decode (DecodedInst.init state) ?features s

let ild_decode state s =
  DecodedInst.ild_decode (DecodedInst.init state) s

let decode_length state s =
  Result.map DecodedInst.get_length @@ ild_decode state s

let encode_nop len =
  let bytes = Bytes.create len in
  match Bind.xed_encode_nop bytes with
  | Enum.NONE -> Ok bytes
  | err -> Error err

let get_copyright = Bind.xed_get_copyright
let get_version = Bind.xed_get_version
let set_verbosity = Bind.xed_set_verbosity

let ok_exn = function Ok x -> x | Error e -> failwith (Enum.error_to_string e)
