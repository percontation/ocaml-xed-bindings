open XedBindings;;
let () = print_endline (Enum.reg_of_string "EAX" |> Enum.reg_to_string)
