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
roc ${NAME}.roc $FROM $TO
