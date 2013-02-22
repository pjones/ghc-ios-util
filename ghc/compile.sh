#!/bin/sh

set -ex
base=`dirname $0`

. $base/env.sh

make maintainer-clean
$base/build.mk.sh
perl boot

# Don't let the following environment variables leak outside of the
# configure script or running make below will fail.
env CPPFLAGS="$TARGET_CPPFLAGS" \
    CFLAGS="$TARGET_CFLAGS" \
    LDFLAGS="$TARGET_LDFLAGS" \
    ./configure \
      --with-local-gcc=/usr/bin/gcc \
      --target=arm-apple-darwin10 \
      --with-alien=`pwd`/alien \
      --prefix=$IOS_GHC_DIR

make # -j3
