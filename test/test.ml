open Xedbindings.Xed

let main () =
  let eax = Enum.reg_of_string "EAX" |> Enum.reg_to_string in
  assert (eax = "EAX");

  let blank = OperandValues.to_string @@ OperandValues.init () in
  assert (blank = "");

  let pushrbp = decode state64 "\x55" |> ok_exn in
  print_endline @@ DecodedInst.to_string pushrbp;

  let shortdecode = decode state32 "\x0f" in
  assert (shortdecode = Error Enum.BUFFER_TOO_SHORT);

  let req = EncoderRequest.of_decoded_inst pushrbp in
  let () = EncoderRequest.set_reg req Enum.REG0 Enum.R15 in
  print_endline @@ EncoderRequest.to_string req;
  let s = EncoderRequest.encode req |> ok_exn in
  decode state64 s |> ok_exn |> DecodedInst.to_string |> print_endline;

  0

let () = exit @@ main ()
