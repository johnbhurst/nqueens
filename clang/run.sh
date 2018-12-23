# Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-02

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
cc -O3 -o $NAME ${NAME}.c
./$NAME $FROM $TO
rm $NAME
