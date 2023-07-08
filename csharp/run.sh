#!/usr/bin/env bash
# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-02-04

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
dotnet run --project ${NAME}.csproj $FROM $TO
