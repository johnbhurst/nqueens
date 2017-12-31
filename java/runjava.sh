# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-01

NAME=$1
FROM=$2
TO=$3

javac ${NAME}.java
java -classpath . $NAME $FROM $TO
