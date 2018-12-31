# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)

clang/run.sh      Queens  8 16 | sed -e "s/^/clang,/"      > clang.csv
clojure/run.sh    Queens  8 15 | sed -e "s/^/clojure,/"    > clojure.csv
cplusplus/run.sh  Queens  8 16 | sed -e "s/^/cplusplus,/"  > cplusplus.csv
crystal/run.sh    Queens  8 15 | sed -e "s/^/crystal,/"    > crystal.csv
csharp/run.sh     Queens  8 16 | sed -e "s/^/csharp,/"     > csharp.csv
elixir/run.sh     Queens  8 15 | sed -e "s/^/elixir,/"     > elixir.csv
fsharp/run.sh     Queens  8 15 | sed -e "s/^/fsharp,/"     > fsharp.csv
golang/run.sh     Queens  8 16 | sed -e "s/^/golang,/"     > golang.csv
groovy/run.sh     Queens  8 15 | sed -e "s/^/groovy,/"     > groovy.csv
haskell/run.sh    Queens  8 15 | sed -e "s/^/haskell,/"    > haskell.csv
java/run.sh       Queens  8 16 | sed -e "s/^/java,/"       > java.csv
javascript/run.sh Queens  8 16 | sed -e "s/^/javascript,/" > javascript.csv
julia/run.sh      Queens  8 15 | sed -e "s/^/julia,/"      > julia.csv
kotlin/run.sh     Queens  8 16 | sed -e "s/^/kotlin,/"     > kotlin.csv
perl/run.sh       Queens  8 14 | sed -e "s/^/perl,/"       > perl.csv
python/run.sh     Queens  8 14 | sed -e "s/^/python,/"     > python.csv
ruby/run.sh       Queens  8 14 | sed -e "s/^/ruby,/"       > ruby.csv
scala/run.sh      Queens  8 16 | sed -e "s/^/scala,/"      > scala.csv
swift/run.sh      Queens  8 15 | sed -e "s/^/swift,/"      > swift.csv

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