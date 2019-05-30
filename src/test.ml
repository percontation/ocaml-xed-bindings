open Xed
open Result

let (>>=) a b = match a with Ok x -> b x | Error _ as y -> y
let (>>|) a b = match a with Ok x -> Ok (b x) | Error _ as y -> y

let main () =
  let eax = Enum.reg_of_string "EAX" |> Enum.reg_to_string in
  assert (eax = "EAX");
  let blank = OperandValues.to_string @@ OperandValues.init () in
  assert (blank = "");
  let () = match decode state64 "\x55" with
    | Ok x -> DecodedInst.to_string x |> print_endline; DecodedInst.disassemble x INTEL 0L |> print_endline
    | Error x -> prerr_string "Error: "; prerr_endline (Enum.error_to_string x); assert false
  in
  let shortdecode = decode state32 "\x0f" in
  assert (shortdecode = Error Enum.BUFFER_TOO_SHORT);
  0

let () = Pervasives.exit @@ main ()
