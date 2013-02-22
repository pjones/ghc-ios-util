#!/bin/sh

################################################################################
# For each git repository in the current directory (including the
# current directory) switch to the ios branch or another appropriate
# branch.

################################################################################
# Nice way to die.
die () {
  echo "ERROR: " "$@" > /dev/stderr
  exit 1
}

################################################################################
# Checkout the given branch.
checkout () {
  dir=$1
  branch=$2

  name=`basename $dir`
  printf "%s: %s" $name $branch

  (cd $dir && \
    git checkout -q $branch) \
    || die "in $dir: failed to checkout $branch branch"

  echo # newline
}

################################################################################
# These repositories need to be on specific commits/branches.
checkout ghc-tarballs                18e0c37f8023abf469af991e2fc2d3b024319c27
checkout libraries/Win32             21335a30161c099da79ae9619c9782e5e32e4644
checkout libraries/array             81df1ffbd3d1ebbbf5eedf9ce7ee770cec93773c
checkout libraries/binary            2d31cea238d0d08885c457475fc354dbf2b88976
checkout libraries/bytestring        aaf84424aee2bac53b5121115b95ae47bcce17a2
checkout libraries/containers        a9b7224068ae60f73baacd5f76d2c27624d90120
checkout libraries/deepseq           420507ea418db8664a79aedaa6588b772e8c97c6
checkout libraries/directory         remotes/origin/ghc-7.4
checkout libraries/filepath          abf31a9aef45d2119a5757dafbe4adf611388ee8
checkout libraries/ghc-prim          529167773a9a036d7d3262707be4c5a2f6a04bcf
checkout libraries/haskeline         38d57bef2807443b84680f78a9bdb6c59c907192
checkout libraries/haskell2010       71bea78ccdbcd8bb8095dee2ebab8423e19ca959
checkout libraries/haskell98         df1846099be1a7220e7d46aef167403eed53ebe5
checkout libraries/hoopl             remotes/origin/ghc-7.4
checkout libraries/hpc               f38d16f27e632510bc1c7269b84952f171c1fd7c
checkout libraries/integer-simple    30c4af5165f181ef4f089b3d245371230f0aafad
checkout libraries/old-locale        df98c76b078de507ba2f7f23d4473c0ea09d5686
checkout libraries/old-time          859d376b0ef1602dcb9514b6f3440bcd27006393
checkout libraries/pretty            ab7e8d91470bb94c9e184dffbec89d0aae116f9b
checkout libraries/process           remotes/origin/ghc-7.4
checkout libraries/template-haskell  0b8e8c027296580c6b512e52e12af3aa8f76546f
checkout libraries/transformers      a59fb93860f84ccd44178dcbbb82cfea7e02cd07
checkout libraries/utf8-string       d7386bea7fe286483ea559fb9b3898be080af700
checkout libraries/xhtml             fb9e0bbb69e15873682a9f25d39652099a3ccac1
checkout utils/haddock               85b8ac017f0ac6d3eda397e586a75bb9f7c2760b

################################################################################
# If a repository has an "ios" branch, use that instead.
for sb in `find . -type d -name .git`; do
  ( # New sub-shell to avoid having to cd back to where we were.
    cd `dirname $sb`

    if git branch -a 2>&1 | grep -q '/ios'; then
      checkout `pwd` ios && git pull -q
    fi
  )
done
