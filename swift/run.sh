# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-09

FROM=${1:-8}
TO=${2:-$FROM}

swiftc -o Queens -O Sources/Queens/main.swift
./Queens $FROM $TO | tee swift.csv

