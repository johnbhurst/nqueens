// $Id:queens.cpp 674 2007-04-01 00:53:57Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-26 

#include <ctime>
#include <iostream>
#include <string>
#include "board.h"

int main (int argc, char *argv[]) {
  if (argc < 2) {
    std::cerr << "I need a number." << std::endl;
    exit(-1);
  }
  int size = atoi(argv[1]);
  Board b(size);
  time_t start = time(0);
  if (b.solve()) {
    time_t elapsed = time(0) - start;
    for (int i = 0; i < size; i++) {
      std::cout << std::string(b.col(i), ' ') << "*" << std::endl;
    }
    std::cout << elapsed << " seconds." << std::endl;
  }
  return(0);
}

