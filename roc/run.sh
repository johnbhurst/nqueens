#!/usr/bin/env bash
# Copyright 2026 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2026-11-07

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
# Hide build output, but show it if the build fails. roc build exits with
# status 2 for warnings alone, so check for the executable instead.
rm -f ${NAME}
roc build ${NAME}.roc --opt=speed >roc.out 2>&1
[[ -x ${NAME} ]] || { cat roc.out >&2; exit 1; }
./${NAME} $FROM $TO
