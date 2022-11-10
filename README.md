# Xed Bindings

Bindings to XED from OCaml.

## Build

Run `xed-build.sh`, and then `dune`.

# Install

For clients: No need to download the repo, just `opam pin add xed-bindings git@.../ocaml-xed-bindings.git`.

For developers: `make install` (installs via ocamlfind, so it will probably live in `~/.opam/myswitch/lib/xed-bindings`).

# Usage notes

Clients should only access the package via the XedBindings module.

The installed package "xed-bindings" should work in utop and ocamlc/ocamlopt.

Warning: This binding isn't safe with respect to bounds checking; e.g. calling `Inst.operand x 9999999` is real bad.

A signature is installed to ~/.opam/*/lib/xed-bindings/XedBindings.inferred.mli. Sorry for XED's ten thousand enums :|

# About

This binding is a pretty direct mapping to XED, exposing most functions and enums but with slightly more idiomatic OCaml names.

XED structures are handled as opaque types, e.g. `xed_decoded_inst_t` is `XedBindings.DecodedInst.t`. XED functions that resemble methods on a struct have been sorted into modules, e.g. `xed_decoded_inst_get_length` is `XedBindings.DecodedInst.get_length`. As with their XED counterparts, these structures are generally mutable. You'll see ``[<`C|`M]`` as parameters to the OCaml opaque types; these are to prevent attempted modification of const struct pointers and should't get in your way unless you're breaking const-correctness in the XED api.

XED enums are exposed as OCaml constructors in `XedBindings.Enum`. XED functions who's domain and codomain are enums are also in this module. The enum–string conversion functions are there too and have been renamed, e.g. `xed_reg_enum_t2str` and `str2xed_reg_enum_t` are now `reg_to_string` and `reg_of_string` respectively. There are also `foo_to_int` & `foo_of_int` functions, but you typically shouldn't need those.

Many XED functions that initialize a particular XED structure have been modified to both allocate and initialize; e.g. `xed_decode` is `XedBindings.decode : 'a XedBindingsStructs.State.t -> string -> ('b DecodedInst.t, Enum.error) result`.

The binding is based on Ctypes, so you'll occasionally need modules like Unsigned.UInt32 to interact with it. It's common in for xed-bindings to use types that make sense for C and not for OCaml, e.g. returning Unsigned.UInt8.t or int when logically it should be a bool, or using Unsigned.UInt32.t for small values that should just be OCaml ints. For popular functions, consider adding a wrapper (that replaces the original function) to src/XedBindings.ml.

# Example

```
#require "xed-bindings";;
open XedBindings;;
(* state64 is convenience; you could make one yourself with State.init2 Enum.LONG_64 Enum.A64b *)
let xedd = decode state64 "\x55";;
let Ok xedd = xedd;; (* "\x55" is valid, ignore the possibility of an Error *)
let () = DecodedInst.get_reg xedd Enum.REG0 |> Enum.reg_to_string |> print_endline;; (* "RBP" *)
let () = DecodedInst.inst xedd |> Inst.iform_enum |> Enum.iform_to_iclass_string_att |> print_endline;; (* "PUSH" *)
(* DecodedInst.disassemble is a special wrapper for xed_format_context. *)
let () = DecodedInst.disassemble xedd Enum.ATT 0xdeadbeefL |> print_endline;; (* "pushq  %rbp" *)
```

Also see src/test.ml
