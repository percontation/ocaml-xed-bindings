#!/bin/sh
set -ue
case ${0-} in
  */*) cd -- "${0%/*}" ;;
  *) ;;
esac

cd xed
rm -Rf kits/xed-install
# I'm not sure if I should try to strip extra args off of c_compiler
: ${CC:=`ocamlc -config-var c_compiler || :`}
: ${CC:=cc}
command -v "$CC" >/dev/null
command -v ar >/dev/null
read -r T <<EOF
`$CC --version`
EOF
case $T in
  *clang*) COMPILER=--compiler=clang ;;
  *gcc*) COMPILER=--compiler=gnu ;;
  *) COMPILER='' ;;
esac
for X in --shared ''; do
  PYTHONPATH="`pwd`/../mbuild${PYTHONPATH+:}${PYTHONPATH-}" python3 -c '
import sys, shlex
sys.argv = ["mfile.py"] + sys.argv[sys.argv.index("--")+1:]
print(" ".join(shlex.quote(i) for i in sys.argv))

import mbuild.env

# mbuild screams and dies for absolutely no reason on non-x86 cpus.
orig_normalize_os_name = mbuild.env.env_t._normalize_os_name
def _normalize_os_name(self, name):
  try:
    return orig_normalize_os_name(self, name)
  except SystemExit:
    return name
mbuild.env.env_t._normalize_os_name = _normalize_os_name

orig_normalize_cpu_name = mbuild.env.env_t._normalize_cpu_name
def _normalize_cpu_name(self, name):
  try:
    return orig_normalize_cpu_name(self, name)
  except SystemExit:
    return name
mbuild.env.env_t._normalize_cpu_name = _normalize_cpu_name

import mfile
sys.exit(mfile.work())
' -- $COMPILER $X --cc="$CC" --cxx="$CC" --linker="$CC" --ar=ar --no-werror --extra-flags=-fPIC --install-dir=kits/xed-install install
# TODO: enable --asserts? Seems to work well with our XedAbort exception but I haven't tested much.
# --cxx="$CC" is "correct" and necessary. XED has no c++, but mbuild uses CXX as the linker anyways.
done
cd ..

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
