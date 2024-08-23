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

let contains_substr haystack needle =
  let last = String.length haystack - String.length needle in
  if String.length needle < 1 then true else
  let rec f i =
    if i > last then false else
    if haystack.[i] = needle.[0] && String.sub haystack i (String.length needle) = needle then true
    else f (i+1)
  in f 0

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

  (* test xed_asserts *)
  let movmem = ok_exn @@ decode state64 "\x8B\x45\x10" in
  assert (DecodedInst.get_memory_displacement movmem 0 = 16L);
  assert (DecodedInst.get_memory_displacement movmem 1 = 0L);
  begin try
    assert (DecodedInst.get_memory_displacement movmem 2 = 0L);
    print_endline "XED_ASSERTS off"
  with XedAbort _ -> print_endline "XED_ASSERTS on"
  end;

  (* test symbolizer *)
  let jmprel = ok_exn @@ decode state64 "\xFF\x25\xE9\xBE\x00\x00" in
  let s = DecodedInst.format ~symbolizer:(fun addr -> Some ("base", addr)) jmprel 0xdead0000L in
  print_endline s; assert (contains_substr s "deadbeef");

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
