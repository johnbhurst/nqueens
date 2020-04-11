# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-08

sudo apt-get -y install git
sudo apt-get -y install golang

git clone https://github.com/johnbhurst/nqueens.git

cd nqueens/golang

sh ./rungo.sh queens_parallel 8 16
