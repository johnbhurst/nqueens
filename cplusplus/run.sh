# # Copyright 2018 John Hurst
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
g++ -O3 -std=c++11 -o $NAME ${NAME}.cpp
./$NAME $FROM $TO
rm $NAME

