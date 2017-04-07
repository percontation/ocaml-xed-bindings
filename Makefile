OCAMLBUILD := ocamlbuild -use-ocamlfind -no-links -Is generated -Xs xed,mbuild \
  -cflags -ccopt,-I../xed/obj,-ccopt,-I../xed/include/public/xed

.PHONY: all clean
all: test

clean:
	rm -Rf ./_build ./generated

.PHONY: bindings
bindings: generate_bindings.py
	mkdir -p generated
	./generate_bindings.py

stubs: bindings
	${OCAMLBUILD} generate_stubs.native
	./_build/generate_stubs.native

.PHONY: test
test: bindings stubs
	${OCAMLBUILD} xbcstubs.o
	${OCAMLBUILD} -lflags -cclib,generated/xbcstubs.o,-cclib,../xed/obj/libxed.a test.native
	./_build/test.native || true

# .PHONY: phony
# _build/%: phony
# 	${OCAMLBUILD} "`basename '$@'`"
