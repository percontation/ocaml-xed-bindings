#!/bin/sh
set -ue

( cd xed && exec ./mfile.py --no-werror --extra-flags=-fPIC )

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
cp -R xed/obj/wkit/include/xed "$OUT/include/"
cp -R xed/obj/wkit/lib/libxed.a "$OUT/lib/"

# dune currently wants to see this, even though it never gets used
touch "$OUT/lib/dllxed.so"
