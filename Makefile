# ocamlbuild gets mad in parallel.
.NOTPARALLEL:

OCAMLBUILD := ocamlbuild -use-ocamlfind -j 4 \
	-no-links -Is src,generated -Xs xed,mbuild \
	-cflags -strict-sequence

.PHONY: all clean install uninstall
all: lib test

clean:
	rm -Rf ./_build ./generated

install: lib
	# This is dumb and I should figure out how to use oasis
	ocamlfind install xed-bindings META `find _build/ -name '*.so' -o -name '*.a' -o -name '*.mli' -o -name '*.cmi' -o -name '*.cma' -o -name '*.cmxa' -o -name '*.cmxs'`

uninstall:
	ocamlfind remove xed-bindings

.PHONY: lib
lib: stubs _build/dllxedbindings.so
	${OCAMLBUILD} src/XedBindings.cmi src/XedBindings.cma src/XedBindings.cmxa src/XedBindings.a src/XedBindings.cmxs

.PHONY: xed
xed:
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
	./_build/src/test.native || true

_build/dllxed.so: xed
	cc -shared xed/obj/libxed.a -o $@

ifeq ($(shell uname),Darwin)
WLIGNORE := -Wl,-flat_namespace,-undefined,dynamic_lookup
else
WLIGNORE := -Wl,--unresolved-symbols=ignore-all
endif

_build/dllxedbindings.so: stubs _build/dllxed.so
	${OCAMLBUILD} generated/xedbindings_stubs.o
	cc -shared ${WLIGNORE} _build/generated/xedbindings_stubs.o xed/obj/libxed.a -o $@
