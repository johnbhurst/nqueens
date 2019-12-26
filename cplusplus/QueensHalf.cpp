// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-06

#include <iomanip>
#include <iostream>

class Board {
public:
  Board(int size, int row = 0, int cols = 0, int diags1 = 0, int diags2 = 0);
  bool ok(int col);
  Board place(int col);
  int solve_rest();
  int solve();

private:
  int size_;
  int row_ = 0;
  long cols_ = 0;
  long diags1_ = 0;
  long diags2_ = 0;
};

Board::Board(int size, int row, int cols, int diags1, int diags2) {
  size_ = size;
  row_ = row;
  cols_ = cols;
  diags1_ = diags1;
  diags2_ = diags2;
}

bool Board::ok(int col) {
  return ((cols_ & (1 << col)) |
         (diags1_ & (1 << (row_ + col))) |
         (diags2_ & (1 << (row_ - col + size_ - 1)))) == 0;
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

int Board::solve_rest() {
  if (row_ == size_) {
    return 1;
  }
  else {
    int result = 0;
    for (int col = 0; col < size_; col++) {
      if (ok(col)) {
        result += place(col).solve_rest();
      }
    }
    return result;
  }
}

int Board::solve() {
  int result = 0;
  // solve for half the columns on first row, double result for symmetry
  for (int col = 0; col < size_ / 2; col++) {
    result += 2 * place(col).solve_rest();
  }
  // add middle column if odd number
  if (size_ % 2 == 1) {
    result += place(size_ / 2).solve_rest();
  }
  return result;
}

int main(int argc, char** argv) {
  int from = argc < 2 ? 8 : atoi(argv[1]);
  int to = argc < 3 ? from : atoi(argv[2]);

  for (int size = from; size <= to; size++) {
    clock_t start = clock();
    int result = Board(size).solve();
    clock_t end = clock();
    float elapsed = (end - start) / 1000000.0;
    std::cout << size << "," << result << "," << std::setprecision(3) << elapsed << std::endl;
  }
}

