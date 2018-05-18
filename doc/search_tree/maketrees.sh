# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-05-19

mkdir board4
cd board4
groovy ../maketree.groovy 4 >queens4.gv
dot -Tsvg -oqueens4.svg queens4.gv
cd ..

mkdir board5
cd board5
groovy ../maketree.groovy 5 >queens4.gv
dot -Tsvg -oqueens5.svg queens5.gv
cd ..

mkdir board6
cd board6
groovy ../maketree.groovy --lr 6 >queens6.gv
dot -Tsvg -oqueens6.svg queens6.gv
cd ..

mkdir board8
cd board8
groovy ../maketree.groovy --lr 8 >queens8.gv
dot -Tsvg -oqueens8.svg queens8.gv
dot -Tpng -oqueens8.png queens8.gv
cd ..

