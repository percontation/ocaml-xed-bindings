#!/bin/sh
set -ue
cd "`dirname "$0"`"

(
  cd xed
  rm -Rf kits/xed-install
  ./mfile.py --no-werror --extra-flags=-fpic --shared --install-dir=kits/xed-install install
  ./mfile.py --no-werror --extra-flags=-fpic          --install-dir=kits/xed-install install
)

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
cp -R xed/kits/xed-install/include/xed "$OUT/include/"
cp xed/kits/xed-install/lib/libxed.a "$OUT/lib/"

for dll in libxed.so libxed.dylib xed.dll ""; do
  dll="${dll+xed/kits/xed-install/lib/}$dll"
  if test -f "$dll"; then
    cp "$dll" "$OUT/lib/dllxed.so"
    break
  fi
done
if test -e "$OUT/lib/dllxed.so"; then :; else
  # Dune always requires this file, but native builds don't care.
  echo "Failed to build dllxed.so, continuing with an empty stub." >&2
  touch "$OUT/lib/dllxed.so"
fi
