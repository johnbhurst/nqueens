// $Id: board.h 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-25 

#include <vector>

class Board {
public:
  Board(int size);
  int size();
  void place(int row, int col);
  int unplace(int row);
  bool is_ok(int row, int col);
  bool solve();
  int col(int row);

private:
  int size_;
  std::vector<int> pos_;
  std::vector<bool> col_;
  std::vector<bool> diag1_;
  std::vector<bool> diag2_;
};
