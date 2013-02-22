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
  branch=$1
  dir=`pwd|xargs -n 1 basename`
  printf "%s: %s" $dir $branch
  git checkout -q $branch || die "in $dir: failed to checkout $branch branch"
  echo # newline
}

################################################################################
# These repositories need to be on specific commits/branches.
(cd libraries/array     && checkout 81df1ffbd3d1ebbbf5eedf9ce7ee770cec93773c)
(cd libraries/directory && checkout remotes/origin/ghc-7.4)
(cd libraries/ghc-prim  && checkout 529167773a9a036d7d3262707be4c5a2f6a04bcf)
(cd libraries/haskeline && checkout 38d57bef2807443b84680f78a9bdb6c59c907192)
(cd libraries/hoopl     && checkout remotes/origin/ghc-7.4)
(cd libraries/process   && checkout remotes/origin/ghc-7.4)

################################################################################
# If a repository has an "ios" branch, use that instead.
for sb in `find . -type d -name .git`; do
  ( # New sub-shell to avoid having to cd back to where we were.
    cd `dirname $sb`

    if git branch -a 2>&1 | grep -q '/ios'; then
      checkout ios && git pull -q
    fi
  )
done
