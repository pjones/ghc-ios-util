#!/bin/sh

set -ex
base=`dirname $0`

. $base/env.sh

export CPPFLAGS="$TARGET_CPPFLAGS"
export CFLAGS="$TARGET_CFLAGS"
export LDFLAGS="$TARGET_LDFLAGS"

test -r Makefile && make maintainer-clean

$base/build.mk.sh
perl boot

./configure \
    --with-local-gcc=/usr/bin/gcc \
    --target=arm-apple-darwin10 \
    --with-alien=`pwd`/alien \
    --prefix=$IOS_GHC_DIR

make -j3
