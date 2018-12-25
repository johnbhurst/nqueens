# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-01

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
javac ${NAME}.java
java -classpath . $NAME $FROM $TO
rm *.class
