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
            A"../xed/obj/libxed.a";
          ]);

    flag ["link"; "ocaml"; "native"; "use_xed"]
      (S[P"generated/xedbindings_genstubs.o";
         P"src/xedbindings_stubs.o";
         A"../xed/obj/libxed.a";
       ]);

    flag ["link"; "ocaml"; "byte"; "use_xed"] (S[A"-dllib"; A"-lxedbindings"]);

  | _ -> ()
end
