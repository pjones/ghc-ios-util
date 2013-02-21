#!/bin/sh

set -ex

perl boot
. env.sh
./config.sh
make
