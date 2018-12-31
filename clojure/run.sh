# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
lein uberjar
java -jar target/queens-0.1.0-SNAPSHOT-standalone.jar 8 15
