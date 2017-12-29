# Copyright 2017 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2017-12-30

NAME=$1
FROM=$2
TO=$3
groovyc ${NAME}.groovy
java -classpath $GROOVY_HOME/embeddable/groovy-all-2.4.12.jar:$GROOVY_HOME/lib/gpars-1.2.1.jar:$GROOVY_HOME/lib/jsr166y-1.7.0.jar:. $NAME $FROM $TO
