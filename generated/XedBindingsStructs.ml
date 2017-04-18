(* 'a [`C] myptr is const; 'a [`M] myptr is non const. The reason for this
   representation is that polymorphic variants are the only way to get cross-
   module automatic subtyping (that I could find, as of 4.04), which allows
   using writing signatures that accept const or mutable. The generated Ctypes
   module won't support this, but our (generated) wrapper module can. *)
type (+'a, +'b) myptr
let const : ('a, [<`M|`C]) myptr -> ('a, [`C]) myptr = Obj.magic
let _allocate n : ('a, [`M]) myptr = Ctypes.allocate_n Ctypes.char n |> Obj.magic

module ChipFeatures = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 32 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module DecodedInst = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 192 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module EncoderRequest = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 192 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module FlagAction = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 8 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module FlagSet = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 4 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module Inst = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 12 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module Operand = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 12 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module OperandValues = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 192 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module SimpleFlag = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 20 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
module State = struct
  type _t
  type +'a t = (_t, 'a) myptr
  let allocate () : [`M] t = _allocate 8 |> Obj.magic
  let pointer : [`M] t -> unit Ctypes.ptr = Obj.magic
  let const_pointer : [<`M|`C] t -> unit Ctypes.ptr = Obj.magic
end
