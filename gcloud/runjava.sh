# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-08

sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install openjdk-8-jdk

git clone https://github.com/johnbhurst/nqueens.git

cd nqueens/java

sh ./runjava.sh QueensStreamParallel 8 16
