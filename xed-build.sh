#!/bin/sh
set -ue
cd "`dirname "$0"`"

( cd xed && exec ./mfile.py --no-werror --extra-flags=-fpic --install-dir=kits/xed-install install )

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
cp -R xed/kits/xed-install/include/xed "$OUT/include/"
cp -R xed/kits/xed-install/lib/libxed.a "$OUT/lib/"

# dune currently wants to see this, even though it never gets used
touch "$OUT/lib/dllxed.so"

dune build
