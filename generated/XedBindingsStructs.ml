(* We use a phantom permission type, where [`Read] indicates readability,
 * [`Write of [`Yes]] indicates writeability, and [`Write of [`No]] indicates
 * immutability. It's our own version of Core_kernel.Perms, so see that.
 * Note that basically everything requires & is granted `Read because we don't
 * have a reasonable way to infer that from the C api. *)
type (+'a, -'perms) myptr
let const : ('a, [>`Read]) myptr -> ('a, [`Read]) myptr = Obj.magic
let _allocate n : ('a, [<`Read|`Write of [`Yes]]) myptr = Ctypes.allocate_n Ctypes.char n |> Obj.magic

module ChipFeatures = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 40 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module DecodedInst = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 192 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module EncoderInstruction = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 416 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module EncoderRequest = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 192 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module FlagAction = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 8 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module FlagSet = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 4 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module Inst = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 12 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module Operand = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 12 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module OperandValues = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 192 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module SimpleFlag = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 20 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
module State = struct
  type _t
  type -'a t = (_t, 'a) myptr
  let allocate () : [<`Read|`Write of [`Yes]] t = _allocate 8 |> Obj.magic
  let pointer : [>`Read|`Write of [`Yes]] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [>`Read] t -> unit Ctypes.ptr = Obj.magic
end
