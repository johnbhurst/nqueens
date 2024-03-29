#!/usr/bin/env bash
# Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-02

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
cc -O3 -o $NAME ${NAME}.c
./$NAME $FROM $TO
rm $NAME
