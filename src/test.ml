open XedBindings

let main () =
  let eax = Enum.reg_of_string "EAX" |> Enum.reg_to_string in
  assert (eax = "EAX");
  let blank = OperandValues.to_string @@ OperandValues.init () in
  assert (blank = "");
  let () = match decode "\x55" with
    | Ok x -> DecodedInst.to_string x |> print_endline
    | Error x -> prerr_string "Error: "; prerr_endline (Enum.error_to_string x); assert false
  in
  let shortdecode = decode "\x0f" in
  assert (shortdecode = Error Enum.BUFFER_TOO_SHORT);
  0

let () = Pervasives.exit @@ main ()
