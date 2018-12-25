# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-09

DIR=$(dirname $0)
NAME=$1
FROM=${2:-8}
TO=${3:-$FROM}

cd $DIR
swiftc -o $NAME -O Sources/$NAME/main.swift
./$NAME $FROM $TO
rm $NAME
