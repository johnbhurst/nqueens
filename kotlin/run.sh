# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-01

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
kotlinc ${NAME}.kt -include-runtime -d ${NAME}.jar
java -jar ${NAME}.jar $FROM $TO
rm ${NAME}.jar
