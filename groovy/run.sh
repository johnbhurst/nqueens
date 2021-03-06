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
GROOVY_LIB=$(ls $GROOVY_HOME/embeddable/groovy-all-*.jar|egrep -v indy)
GPARS_LIB=$(ls $GROOVY_HOME/lib/gpars*.jar)
JSR166_LIB=$(ls $GROOVY_HOME/lib/jsr166*.jar)
java -classpath $GROOVY_LIB:$GPARS_LIB:$JSR166_LIB:. $NAME $FROM $TO
rm *.class
