# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)

clang/run.sh      Queens  8 16 > clang.csv
clojure/run.sh    Queens  8 15 > clojure.csv
cplusplus/run.sh  Queens  8 16 > cplusplus.csv
crystal/run.sh    Queens  8 15 > crystal.csv
csharp/run.sh     Queens  8 16 > csharp.csv
elixir/run.sh     Queens  8 15 > elixir.csv
fsharp/run.sh     Queens  8 15 > fsharp.csv
golang/run.sh     Queens  8 16 > golang.csv
groovy/run.sh     Queens  8 15 > groovy.csv
haskell/run.sh    Queens  8 15 > haskell.csv
java/run.sh       Queens  8 16 > java.csv
javascript/run.sh Queens  8 16 > javascript.csv
julia/run.sh      Queens  8 15 > julia.csv
kotlin/run.sh     Queens  8 16 > kotlin.csv
perl/run.sh       Queens  8 14 > perl.csv
python/run.sh     Queens  8 14 > python.csv
ruby/run.sh       Queens  8 14 > ruby.csv
scala/run.sh      Queens  8 16 > scala.csv
swift/run.sh      Queens  8 15 > swift.csv

groovy $DIR/combine.groovy \
  perl.csv  \
  ruby.csv  \
  python.csv  \
  elixir.csv  \
  groovy.csv  \
  haskell.csv  \
  clojure.csv  \
  fsharp.csv  \
  crystal.csv  \
  swift.csv  \
  julia.csv  \
  scala.csv  \
  csharp.csv  \
  kotlin.csv  \
  golang.csv  \
  javascript.csv  \
  clang.csv  \
  cplusplus.csv  \
  java.csv  \
  > all.csv