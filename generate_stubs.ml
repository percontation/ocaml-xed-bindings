let main () =
  let ml_out = open_out "generated/xbmlstubs.ml"
  and c_out = open_out "generated/xbcstubs.c" in
  let ml_fmt = Format.formatter_of_out_channel ml_out
  and c_fmt = Format.formatter_of_out_channel c_out in
  Format.pp_print_string c_fmt "#include <xed-interface.h>\n";
  Cstubs.write_ml ml_fmt ~prefix:"xbstub_" (module Functions.Bindings);
  Cstubs.write_c c_fmt ~prefix:"xbstub_" (module Functions.Bindings);
  Format.pp_print_flush ml_fmt ();
  Format.pp_print_flush c_fmt ();
  close_out ml_out;
  close_out c_out

let () = main ()
