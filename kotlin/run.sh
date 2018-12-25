# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-01

DIR=$(dirname $0)
NAME=$1
FROM=$2
TO=$3

cd $DIR
kotlinc ${NAME}.kt -include-runtime -d ${NAME}.jar
java -jar ${NAME}.jar $FROM $TO
rm ${NAME}.jar
