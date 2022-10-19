open Xed

let main () =
  let eax = Enum.reg_of_string "EAX" |> Enum.reg_to_string in
  assert (eax = "EAX");

  let blank = OperandValues.to_string @@ OperandValues.init () in
  assert (blank = "");

  let pushrbp = decode state64 "\x55" |> ok_err in
  print_endline @@ DecodedInst.to_string pushrbp;
  print_endline @@ DecodedInst.disassemble pushrbp INTEL 0L;

  let shortdecode = decode state32 "\x0f" in
  assert (shortdecode = Error Enum.BUFFER_TOO_SHORT);

  let req = EncoderRequest.of_decoded_inst pushrbp in
  let () = EncoderRequest.set_reg req Enum.REG0 Enum.R15 in
  EncoderRequest.to_string req |> print_string;
  let s = EncoderRequest.encode req |> ok_err in
  decode state64 s |> ok_err |> DecodedInst.to_string_intel |> print_endline;

  0

let () = exit @@ main ()
