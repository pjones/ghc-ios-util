#!/bin/sh

cat > mk/build.mk <<EOF
SRC_HC_OPTS        = -H64m -O2
SplitObjs          = NO
HADDOCK_DOCS       = NO
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO
INTEGER_LIBRARY    = integer-simple
EOF
