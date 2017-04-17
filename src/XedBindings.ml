let cstring x = Bytes.sub_string x 0 (try Bytes.index x '\x00' with Not_found -> Bytes.length x)

module ChipFeatures = struct
  include XedBindingsApi.ChipFeatures
end

module DecodedInst = struct
  include XedBindingsApi.DecodedInst
  let to_string x =
    let bytes = Bytes.create 1024
    in dump x bytes; cstring bytes
  let to_string_xedfmt x addr =
    let bytes = Bytes.create 1024
    in dump_xed_format x bytes addr, cstring bytes
end

module EncoderRequest = struct
  include XedBindingsApi.EncoderRequest
end

module FlagAction = struct
  include XedBindingsApi.FlagAction
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module FlagSet = struct
  include XedBindingsApi.FlagSet
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Inst = struct
  include XedBindingsApi.Inst
end

module Operand = struct
  include XedBindingsApi.Operand
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes; cstring bytes
end

module Operand3 = struct
  include XedBindingsApi.Operand3
end

module OperandValues = struct
  include XedBindingsApi.OperandValues
  let to_string x =
    let bytes = Bytes.create 128
    in dump x bytes; cstring bytes
  let to_string_short x =
    let bytes = Bytes.create 128
    in print_short x bytes; cstring bytes
end

module SimpleFlag = struct
  include XedBindingsApi.SimpleFlag
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module State = struct
  include XedBindingsApi.State
  let to_string x =
    let bytes = Bytes.create 128
    in print x bytes |> Bytes.sub_string bytes 0
end

module Enum = XedBindingsApi.Enum

let decode s =
  let x = XedBindingsApi.DecodedInst.allocate () in
  match XedBindingsApi.xed_decode x s with
  | Enum.NONE -> Ok x
  | err -> Error err

let decode_with_features s chipfeat =
  let x = XedBindingsApi.DecodedInst.allocate () in
  match XedBindingsApi.xed_decode_with_features x s chipfeat with
  | Enum.NONE -> Ok x
  | err -> Error err

let () = XedBindingsApi.xed_tables_init ()
