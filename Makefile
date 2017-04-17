# ocamlbuild gets mad in parallel.
.NOTPARALLEL:

OCAMLBUILD := ocamlbuild -use-ocamlfind -j 4 \
	-no-links -Is src,generated -Xs xed,mbuild \
	-cflags -strict-sequence

.PHONY: all clean install uninstall
all: lib test

clean:
	rm -Rf ./_build ./generated

install: lib uninstall
	# This is dumb and I should figure out how to use topkg
	ocamlfind install xed-bindings META _build/dllxedbindings.so `find _build/src _build/generated -name '*.a' -o -name '*.mli' -o -name '*.cmi' -o -name '*.cma' -o -name '*.cmxa' -o -name '*.cmxs'`

uninstall:
	ocamlfind remove xed-bindings

.PHONY: lib
lib: stubs _build/dllxedbindings.so
	${OCAMLBUILD} src/XedBindings.cmi src/XedBindings.cma src/XedBindings.cmxa src/XedBindings.a src/XedBindings.cmxs src/XedBindings.inferred.mli

.PHONY: submodules
submodules:
	git submodule update --init --checkout --recursive -- mbuild
	git submodule update --init --checkout --recursive -- xed

.PHONY: xed
xed: submodules
	cd xed && { test -n "`find obj/xed-reg-enum.h -mtime -1h 2>/dev/null || true`" || { ./mfile.py && touch obj/xed-reg-enum.h; }; }

.PHONY: stubs
stubs: xed generate_bindings.py
	mkdir -p generated
	./generate_bindings.py
	${OCAMLBUILD} generate_stubs.native
	./_build/generate_stubs.native

.PHONY: test
test: stubs
	${OCAMLBUILD} test.native
	./_build/src/test.native

_build/dllxed.so: xed
	cc -shared xed/obj/libxed.a -o $@

ifeq ($(shell uname),Darwin)
WLIGNORE := -Wl,-flat_namespace,-undefined,dynamic_lookup
else
WLIGNORE := -Wl,--unresolved-symbols=ignore-all
endif

_build/dllxedbindings.so: xed stubs src/xedbindings_stubs.c _build/dllxed.so
	${OCAMLBUILD} generated/xedbindings_genstubs.o src/xedbindings_stubs.o
	cc -shared ${WLIGNORE} _build/src/xedbindings_stubs.o _build/generated/xedbindings_genstubs.o xed/obj/libxed.a -o $@

.PHONY: phony
_build/%: phony
	${OCAMLBUILD} ${OFLAGS} '$(@:_build/%=%)'
