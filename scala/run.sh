# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-28

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
scala ${NAME}.scala $FROM $TO
