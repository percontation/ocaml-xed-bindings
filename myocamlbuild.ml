open Ocamlbuild_plugin;;
open Command;;

dispatch begin function
  | After_rules ->
    flag ["compile"; "c"] (S[A"-ccopt"; A"-Os"]);

    flag ["compile"; "c"; "use_xed"]
         (S[A"-ccopt"; A"-I../xed/obj";
            A"-ccopt"; A"-I../xed/include/public/xed";
          ]);

    flag ["link"; "native"; "use_xed"]
         (S[A"-ccopt"; A"-I../xed/obj";
            A"-ccopt"; A"-I../xed/include/public/xed";
            A"-cclib"; A"../xed/obj/libxed.a";
          ]);

    dep ["link"; "ocaml"; "native"; "use_xed"] ["generated/xedbindings_genstubs.o"; "src/xedbindings_stubs.o"];

    flag ["link"; "ocaml"; "byte"; "use_xed"] (S[A"-dllib"; A"-lxedbindings"]);

  | _ -> ()
end
