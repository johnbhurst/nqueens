# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)

clang/run.sh       8 17 > clang.csv
clojure/run.sh     8 16 > clojure.csv
cplusplus/run.sh   8 17 > cplusplus.csv
crystal/run.sh     8 16 > crystal.csv
csharp/run.sh      8 17 > csharp.csv
dart/run.sh        8 17 > dart.csv
elixir/run.sh      8 16 > elixir.csv
fsharp/run.sh      8 16 > fsharp.csv
golang/run.sh      8 17 > golang.csv
groovy/run.sh      8 16 > groovy.csv
haskell/run.sh     8 16 > haskell.csv
java/run.sh        8 17 > java.csv
javascript/run.sh  8 17 > javascript.csv
julia/run.sh       8 17 > julia.csv
kotlin/run.sh      8 17 > kotlin.csv
nim/run.sh         8 17 > nim.csv
perl/run.sh        8 15 > perl.csv
python/run.sh      8 15 > python.csv
ruby/run.sh        8 15 > ruby.csv
rust/run.sh        8 17 > rust.csv
scala/run.sh       8 17 > scala.csv
swift/run.sh       8 17 > swift.csv
