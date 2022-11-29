# Xed Bindings

Bindings to [Intel XED](https://github.com/intelxed/xed) from OCaml.

Warning: This binding isn't safe with respect to bounds checking; e.g. calling `Xed.Inst.operand x 9999999` is real bad.

## Build

Run `xed-build.sh` before building with dune.

## About

This binding is mostly a direct mapping to underlying XED functions, but names have been reorganized to be more idiomatic to OCaml.

XED structures are handled as opaque types, e.g. `xed_decoded_inst_t` is `Xed.DecodedInst.t`. XED functions that resemble methods on a struct have been sorted into modules, e.g. `xed_decoded_inst_get_length` is `Xed.DecodedInst.get_length`. As with their XED counterparts, these structures are generally mutable. You'll see `` [<`Read|`Write] `` as parameters to the OCaml opaque types; these are to prevent attempted modification of const struct pointers and should't get in your way unless you're breaking const-correctness in the XED api.

XED enums are exposed as OCaml constructors in `Xed.Enum`. XED functions that concern only enums are in that module. The enum–string conversion functions are there too and have been renamed, e.g. `xed_reg_enum_t2str` and `str2xed_reg_enum_t` are now `reg_to_string` and `reg_of_string` respectively. There are also `foo_to_int` & `foo_of_int` functions for each enum type, but you typically shouldn't need those.

Many XED functions that initialize a particular XED structure have been modified to both allocate and initialize; e.g. `xed_decode` is `Xed.decode : 'a XedStructs.State.t -> string -> ('b DecodedInst.t, Enum.error) result`.

The binding is based on Ctypes, so you'll occasionally need modules like `Unsigned.UInt32` to interact with it. For high-level functions where there's a type that's more ergonomic for OCaml---e.g. XED functions returning some integer type that could just be a `bool`, or using `Unsigned.UInt32.t` for small values that could just be an `int`---we have replacement functions in `src/xed.ml` that shadow the auto-generated bindings.

## Example

```
#require "xedbindings";;
open Xedbindings.Xed;;
(* state64 is convenience; you could make one yourself with State.init2 Enum.LONG_64 Enum.A64b *)
let xedd = decode state64 "\x55" |> ok_exn;;
let () = DecodedInst.get_reg xedd Enum.REG0 |> Enum.reg_to_string |> print_endline;; (* "RBP" *)
let () = DecodedInst.inst xedd |> Inst.iform_enum |> Enum.iform_to_iclass_string_att |> print_endline;; (* "PUSH" *)
(* DecodedInst.format is a special wrapper for xed_format_generic. *)
let () = DecodedInst.format ~syntax:Enum.ATT xedd 0xdeadbeefL |> print_endline;; (* "pushq  %rbp" *)
```

Also see `src/test.ml`

## Updates

This library may slightly break backwards-compatibility of its API on any minor version update. For example, these incompatibilities may include:

* Minor type changes or function renames for better OCaml ergonomics
* Upstream XED updates (that don't broadly break stuff)

## Future work

* Optional bindings for the "enc2" encoder.
* Custom high-level OCaml to mirror XED's high-level encoding API (which is not currently exposed by this binding).
* Determine what further parts of XED are excluded from the binding, and possibly complete the binding.
