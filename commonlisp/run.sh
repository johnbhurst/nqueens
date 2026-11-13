#!/usr/bin/env bash
# Nick Jones (nick.jones@arachnid.co.nz)
# 2019-04-19

DIR=$(dirname $0)
if [[ $# -eq 3 ]]; then
  NAME=$1
  shift
else
  NAME=Queens
fi
FROM=$1
TO=$2

cd $DIR

# Hide build output, but show it if the build fails.
buildapp --load-system queens --asdf-path . --entry queens:main --output queens >buildapp.out 2>&1 \
  || { cat buildapp.out >&2; exit 1; }
./queens $FROM $TO
rm queens