#!/bin/sh
set -ue
cd "`dirname "$0"`"

(
  cd xed
  ./mfile.py --no-werror --extra-flags=-fpic --install-dir=kits/xed-install-static install
  ./mfile.py --no-werror --shared --install-dir=kits/xed-install-shared install
)

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
cp -R xed/kits/xed-install-static/include/xed "$OUT/include/"
cp xed/kits/xed-install-static/lib/libxed.a "$OUT/lib/"

for dll in libxed.so libxed.dylib xed.dll ""; do
  dll="${dll+xed/kits/xed-install-shared/lib/}$dll"
  if test -f "$dll"; then
    cp "$dll" "$OUT/lib/dllxed.so"
    break
  fi
done
if test -z "$dll"; then
  # Dune always requires this file, but native builds don't care.
  echo "Failed to build dllxed.so, continuing with an empty stub." >&2
  touch "$OUT/lib/dllxed.so"
fi
