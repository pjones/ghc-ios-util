#!/bin/sh

# For each git repository in the current directory (including the
# current directory) switch to the ios branch or another appropriate
# branch.

# Nice way to die.
die () {
  echo "ERROR: " "$@" > /dev/stderr
  exit 1
}

# Checkout the given branch.
checkout () {
  branch=$1
  dir=`pwd|xargs -n 1 basename`
  printf "%s: %s" $dir $branch
  git checkout -q $branch || die "in $dir: failed to checkout $branch branch"
  echo # newline
}

# Some of the repositories need to be on the ios branch.
for sb in `find . -type d -name .git`; do
  base=`dirname $sb`

  ( # New sub-shell to avoid having to cd back to where we were.
    cd $base

    if git branch -a 2>&1 | grep -q '/ios'; then
      checkout ios && git pull -q
    fi
  )
done

# The name of the 7.4 release branch.
relbranch=remotes/origin/ghc-7.4

# Repositories that need to be on the $relbranch.
dirs="
  libraries/directory
  libraries/hoopl
  libraries/process
"

for d in $dirs; do
  (cd $d && checkout $relbranch)
done
