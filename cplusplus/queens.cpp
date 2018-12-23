// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-06

#include <iostream>
#include <future>

class Board {
public:
  Board(int size, int row = 0, int cols = 0, int diags1 = 0, int diags2 = 0);
  bool ok(int col);
  Board place(int col);
  int solve();

private:
  int size_;
  int row_ = 0;
  int cols_ = 0;
  int diags1_ = 0;
  int diags2_ = 0;
};

Board::Board(int size, int row, int cols, int diags1, int diags2) {
  size_ = size;
  row_ = row;
  cols_ = cols;
  diags1_ = diags1;
  diags2_ = diags2;
}

bool Board::ok(int col) {
  return (cols_ & (1 << col)) == 0 &&
         (diags1_ & (1 << (row_ + col))) == 0 &&
         (diags2_ & (1 << (row_ - col + size_ - 1))) == 0;
}

Board Board::place(int col) {
  return Board(
    size_,
    row_ + 1,
    cols_ | 1 << col,
    diags1_ | 1 << (row_ + col),
    diags2_ | 1 << (row_ - col + size_ - 1)
  );
}

int Board::solve() {
  if (row_ == size_) {
    return 1;
  }
  else {
    int result = 0;
    for (int col = 0; col < size_; col++) {
      if (ok(col)) {
        result += place(col).solve();
      }
    }
    return result;
  }
}

int main(int argc, char** argv) {
  std::cout << "Hello world." << std::endl;

  int from = argc < 2 ? 8 : atoi(argv[1]);
  int to = argc < 3 ? from : atoi(argv[2]);

  for (int size = from; size <= to; size++)
  {
    clock_t start = clock();
    int result = Board(size).solve();
    clock_t end = clock();
    int elapsed = (end - start) / 1000;
    printf("Board size %d has %d solutions. Calculated in %dms\n", size, result, elapsed);
  }
}

