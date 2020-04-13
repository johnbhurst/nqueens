# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)

clang/run.sh       8 18 > data/big/clang.csv
clojure/run.sh     8 17 > data/big/clojure.csv
cplusplus/run.sh   8 18 > data/big/cplusplus.csv
crystal/run.sh     8 17 > data/big/crystal.csv
csharp/run.sh      8 18 > data/big/csharp.csv
dart/run.sh        8 18 > data/big/dart.csv
elixir/run.sh      8 17 > data/big/elixir.csv
fsharp/run.sh      8 17 > data/big/fsharp.csv
golang/run.sh      8 18 > data/big/golang.csv
groovy/run.sh      8 17 > data/big/groovy.csv
haskell/run.sh     8 17 > data/big/haskell.csv
java/run.sh        8 18 > data/big/java.csv
javascript/run.sh  8 18 > data/big/javascript.csv
julia/run.sh       8 18 > data/big/julia.csv
kotlin/run.sh      8 18 > data/big/kotlin.csv
nim/run.sh         8 18 > data/big/nim.csv
perl/run.sh        8 16 > data/big/perl.csv
python/run.sh      8 16 > data/big/python.csv
ruby/run.sh        8 16 > data/big/ruby.csv
rust/run.sh        8 18 > data/big/rust.csv
scala/run.sh       8 18 > data/big/scala.csv
swift/run.sh       8 18 > data/big/swift.csv
