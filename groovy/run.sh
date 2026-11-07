#!/usr/bin/env bash
# Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-12-30

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
groovyc ${NAME}.groovy
java -classpath "$GROOVY_HOME/lib/*:." $NAME $FROM $TO
rm *.class
