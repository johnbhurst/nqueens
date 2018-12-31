# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-06

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
ghc ${NAME}.hs >/dev/null
./$NAME $FROM $TO
rm $NAME
rm ${NAME}.hi
rm ${NAME}.o
