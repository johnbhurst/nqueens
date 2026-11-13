# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-12-31

DIR=$(dirname $0)

clang/run.sh       8 14 > clang.csv
clojure/run.sh     8 14 > clojure.csv
commonlisp/run.sh  8 14 > commonlisp.csv
cplusplus/run.sh   8 14 > cplusplus.csv
crystal/run.sh     8 14 > crystal.csv
csharp/run.sh      8 14 > csharp.csv
dart/run.sh        8 14 > dart.csv
elixir/run.sh      8 14 > elixir.csv
fsharp/run.sh      8 14 > fsharp.csv
golang/run.sh      8 14 > golang.csv
groovy/run.sh      8 14 > groovy.csv
haskell/run.sh     8 14 > haskell.csv
java/run.sh        8 14 > java.csv
javascript/run.sh  8 14 > javascript.csv
julia/run.sh       8 14 > julia.csv
kotlin/run.sh      8 14 > kotlin.csv
nim/run.sh         8 14 > nim.csv
perl/run.sh        8 14 > perl.csv
python/run.sh      8 14 > python.csv
roc/run.sh         8 14 > roc.csv
ruby/run.sh        8 14 > ruby.csv
rust/run.sh        8 14 > rust.csv
scala/run.sh       8 14 > scala.csv
swift/run.sh       8 14 > swift.csv
zig/run.sh         8 14 > zig.csv
