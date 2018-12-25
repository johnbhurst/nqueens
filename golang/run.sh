# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-06

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
go build ${NAME}.go
./$NAME $FROM $TO
rm ${NAME}