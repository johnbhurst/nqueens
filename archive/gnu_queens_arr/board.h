// $Id: board.h 664 2007-03-28 08:00:36Z jhurst $
// Copyright 2007 John Hurst
// John Hurst (jbhurst@attglobal.net)
// 2007-03-25 

#include <vector>

class Board {
public:
  Board(int size);
  ~Board();
  int size();
  void place(int row, int col);
  int unplace(int row);
  bool is_ok(int row, int col);
  bool solve();
  int col(int row);

private:
  int size_;
  int* pos_;
  bool* col_;
  bool* diag1_;
  bool* diag2_;
};
