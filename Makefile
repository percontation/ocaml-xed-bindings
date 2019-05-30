# ocamlbuild gets mad in parallel.
.NOTPARALLEL:

OCAMLBUILD := ocamlbuild -use-ocamlfind -j 4 \
	-no-links -Is src,generated -Xs xed,mbuild \
	-cflags -strict-sequence

.PHONY: all clean veryclean install uninstall
all: lib test

ifeq (${NO_GENERATE},)
clean:
	rm -Rf ./_build ./generated
else
clean:
	rm -Rf ./_build
endif

veryclean: clean
	rm -Rf ./xed/obj

install: lib uninstall
	# This is dumb and I should figure out how to use topkg
	ocamlfind install xed-bindings META _build/dllxedbindings.so _build/src/xedbindings_stubs.o _build/generated/xedbindings_genstubs.o xed/obj/libxed.a `find _build/src _build/generated -name '*.a' -o -name '*.mli' -o -name '*.cmi' -o -name '*.cma' -o -name '*.cmxa' -o -name '*.cmt'`

uninstall:
	ocamlfind remove xed-bindings

.PHONY: lib
lib: stubs _build/dllxedbindings.so
	${OCAMLBUILD} src/Xed.cmi src/Xed.cma src/Xed.cmxa src/Xed.a src/Xed.inferred.mli

.PHONY: submodules
submodules:
	git submodule update --init --checkout --recursive -- mbuild
	git submodule update --init --checkout --recursive -- xed

.PHONY: xed
xed: submodules
	cd xed && { test -n "`find obj/xed-reg-enum.h -mtime -1h 2>/dev/null || true`" || { ./mfile.py --no-werror --extra-flags=-fPIC  && touch obj/xed-reg-enum.h; }; }

.PHONY: stubs
ifeq (${NO_GENERATE},)
stubs: xed generate_bindings.py
	rm -Rf ./generated
	mkdir generated
	./generate_bindings.py
	${OCAMLBUILD} generate_stubs.native
	./_build/generate_stubs.native
else
stubs: generated/XedBindingsEnums.ml generated/XedBindingsGenerated.ml generated/XedBindingsInternal.ml generated/XedBindingsStructs.ml generated/XedBindingsStubs.ml generated/xedbindings_genstubs.c
endif

.PHONY: test
test: stubs
	${OCAMLBUILD} test.native
	./_build/src/test.native

_build/dllxed.so: xed
	mkdir -p _build
	cc -shared xed/obj/libxed.a -o $@

ifeq ($(shell uname),Darwin)
WLIGNORE := -Wl,-flat_namespace,-undefined,dynamic_lookup
else
WLIGNORE := -Wl,--unresolved-symbols=ignore-all
endif

_build/dllxedbindings.so: xed stubs src/xedbindings_stubs.c
	${OCAMLBUILD} generated/xedbindings_genstubs.o src/xedbindings_stubs.o
	cc -shared ${WLIGNORE} _build/src/xedbindings_stubs.o _build/generated/xedbindings_genstubs.o xed/obj/libxed.a -o $@

.PHONY: phony
_build/%: phony
	${OCAMLBUILD} ${OFLAGS} '$(@:_build/%=%)'
