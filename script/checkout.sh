#!/bin/sh

DIRS=". libraries/base libraries/unix libraries/Cabal utils/hsc2hs"

die () {
  echo "ERROR: " "$@" > /dev/stderr
  exit 1
}

for d in $DIRS; do
  (cd $d && git checkout ios) || die "failed to checkout ios in $d"
done
