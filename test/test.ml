open Xedbindings.Xed

let instrs = [
  "\xF3\x48\xA5"; (* rep movsq *)
  "\x64\x8B\x54\x88\x0D";(* mov edx, fs:[rax+rcx*4+13] *)
  "\x41\x8F\x01"; (* pop [r9] *)
  "\x4C\x01\xF8"; (* add rax, r15 *)
  "\xFF\xD7"; (* call rdi *)
  "\xFF\x17"; (* call [rdi] *)
  "\xDE\xC1"; (* faddp *)
]

let testinstrs f =
  let testone f s =
    let xedd = decode state64 s |> ok_exn in
    DecodedInst.to_string xedd |> print_endline;
    print_string "\t";
    print_endline @@ f xedd
  in
  List.iter (testone f) instrs

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

  testinstrs (fun xedd ->
    let init = "" in
    let f _ s op = s
      ^ (Operand.name op |> Enum.operand_to_string)
      ^ ":"
      ^ (DecodedInst.get_reg xedd (Operand.name op) |> Enum.reg_to_string)
      ^ " "
    in
    Inst.fold_left_operands (DecodedInst.inst xedd) ~init ~f);

  0

let () = exit @@ main ()
