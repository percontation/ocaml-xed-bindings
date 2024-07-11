#!/bin/sh
# Creates a release tarball from the git repository.
set -eu
case ${0-} in
  */*) cd -- "${0%/*}" ;;
  *) ;;
esac
test -f xed/LICENSE || { echo "You're in the wrong place" >&2; exit 1; }

test -z "`git status --untracked-files=no --porcelain`" || { echo "git repo is unclean"; exit 1; }
git submodule foreach --recursive --quiet 'test -z "`git status --untracked-files=no --porcelain`" || { echo "$sm_path is unclean"; exit 1; }'

NAME=`git remote get-url origin`
NAME="${NAME##*/}"
NAME="${NAME%.git}"

TARBALL="$NAME-`git describe`.tgz"
rm -f "$TARBALL"

mytar() {
  echo "No suitable tar program found; try gnutar or bsdtar." >&2
  exit 1
}
for TAR in "${TAR-tar}" gnutar bsdtar tar; do
  test -z "$TAR" && continue
  case "`$TAR --version`" in
    *bsdtar*)
mytar() {
  export COPYFILE_DISABLE=1
  "$TAR" --create --file "$TARBALL" --gzip --exclude='.*' --exclude=release.sh --exclude='xed/tests/*' --no-recursion --no-xattrs --format=ustar --numeric-owner --uid=0 --gid=0 -s "|^|$NAME/|" --null --files-from=-
}
      break ;;
    *GNU" "tar*)
mytar() {
  "$TAR" --create --file "$TARBALL" --gzip --exclude='.*' --exclude=release.sh --exclude='xed/tests/*' --no-recursion --no-xattrs --format=ustar --numeric-owner --owner=0 --group=0 --transform="s|^|$NAME/|" --null --files-from=-
}
      break ;;
  esac
done

git ls-files --recurse-submodules -z | mytar
`command -v sha256 || command -v sha256sum || echo 'shasum -a 256'` "$TARBALL"
git rev-parse HEAD
