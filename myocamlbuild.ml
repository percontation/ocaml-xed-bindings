open Ocamlbuild_plugin;;
open Command;;

dispatch begin function
  | After_rules ->
    flag ["compile"; "c"] (S[A"-ccopt"; A"-Os"]);

    flag ["compile"; "c"; "use_xed"]
         (S[A"-ccopt"; A"-I../xed/obj";
            A"-ccopt"; A"-I../xed/include/public/xed";
          ]);

    flag ["link"; "c"; "native"; "use_xed"]
         (S[A"-ccopt"; A"-I../xed/obj";
            A"-ccopt"; A"-I../xed/include/public/xed";
            A"-cclib"; A"../xed/obj/libxed.a";
          ]);

    flag ["link"; "ocaml"; "library"; "native"; "use_xed"]
      (S[A"-ccopt"; P"$CAMLORIGIN/xedbindings_genstubs.o";
         A"-ccopt"; P"$CAMLORIGIN/xedbindings_stubs.o";
         A"-ccopt"; A"$CAMLORIGIN/libxed.a";
       ]);

    flag ["link"; "ocaml"; "program"; "native"; "use_xed"]
      (S[A"-ccopt"; P"generated/xedbindings_genstubs.o";
         A"-ccopt"; P"src/xedbindings_stubs.o";
         A"-ccopt"; A"../xed/obj/libxed.a";
       ]);


    flag ["link"; "ocaml"; "byte"; "use_xed"] (S[A"-dllib"; A"-lxedbindings"]);

  | _ -> ()
end
