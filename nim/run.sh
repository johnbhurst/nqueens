# Copyright 2019 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2019-12-27

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
nim compile -d:release ${NAME}.nim # 2>err
./$NAME $FROM $TO
rm $NAME
