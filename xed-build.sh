#!/bin/sh
set -ue
cd "`dirname "$0"`"

(
  cd xed
  rm -Rf kits/xed-install
  # mbuild be trollin, most macs don't have a llvm-ar.
  AR=`/usr/bin/env python3 -c 'import shutil,mfile;mfile.find_mbuild_import();import xed_mbuild;env = xed_mbuild.mkenv();xed_mbuild.xed_args(env);shutil.which(env.expand_string("%(ARCHIVER)s")) or print(shutil.which("ar"))'`
  ./mfile.py "${AR:+--ar=}$AR" --no-werror --extra-flags=-fpic --shared --install-dir=kits/xed-install install
  ./mfile.py "${AR:+--ar=}$AR" --no-werror --extra-flags=-fpic          --install-dir=kits/xed-install install
)

show () {
  echo "$@" >&2
  "$@"
}

OUT=src/bind/xedkit
rm -Rf "$OUT"
mkdir "$OUT"
mkdir "$OUT/include" "$OUT/lib"
show cp -R xed/kits/xed-install/include/xed "$OUT/include/"
show cp xed/kits/xed-install/lib/libxed.a "$OUT/lib/"

for dll in libxed.so libxed.dylib xed.dll ""; do
  dll="${dll+xed/kits/xed-install/lib/}$dll"
  if test -f "$dll"; then
    show cp "$dll" "$OUT/lib/dllxed.so"
    break
  fi
done
if test -e "$OUT/lib/dllxed.so"; then :; else
  # Dune always requires this file, but native builds don't care.
  echo "Failed to build dllxed.so, continuing with an empty stub." >&2
  show touch "$OUT/lib/dllxed.so"
fi
