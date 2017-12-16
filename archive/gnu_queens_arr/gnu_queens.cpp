// $Id: gnu_queens.cpp 673 2007-03-31 23:05:52Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-26 

#include <iostream>
#include <ctime>
#include "board.h"

int main (int argc, char *argv[]) {
  if (argc < 1) {
    std::cerr << "I need a number." << std::endl;
    exit(-1);
  }
  int size = atoi(argv[1]);
  Board b(size);
  time_t start = time(0);
  if (b.solve()) {
    time_t elapsed = time(0) - start;
    for (int i = 0; i < size; i++) {
      int col = b.col(i);
      for (int j = 0; j < col; j++) {
        std::cout << " ";
      }
      std::cout << "*" << std::endl;
    }
    std::cout << elapsed << " seconds." << std::endl;
  }
  return(0);
}

