#!/bin/sh
set -ue
cd "`dirname "$0"`"

( cd xed && exec ./mfile.py --no-werror --shared --extra-flags=-fpic --install-dir=kits/xed-install install )

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
cp -R xed/kits/xed-install/include/xed "$OUT/include/"
cp xed/kits/xed-install/lib/libxed.a "$OUT/lib/"

for dll in libxed.so libxed.dylib ""; do
  dll="${dll+xed/kits/xed-install/lib/}$dll"
  if test -f "$dll"; then
    cp "$dll" "$OUT/lib/dllxed.so"
    break
  fi
done
if test -z "$dll"; then
  # dllxed.so must be present, but most builds don't actually use it.
  touch "$OUT/lib/dllxed.so"
fi
