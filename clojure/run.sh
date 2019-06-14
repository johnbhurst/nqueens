# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

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
lein uberjar
java -jar target/queens-0.1.0-SNAPSHOT-standalone.jar $FROM $TO
