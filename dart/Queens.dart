// Copyright 2019 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2019-12-27

class Board {
  int size;
  int row = 0;
  int cols = 0;
  int diags1 = 0;
  int diags2 = 0;

  Board(int size) {
    this.size = size;
  }

  bool ok(int col) {
    return ((this.cols & (1 << col)) |
      (this.diags1 & (1 << this.row + col)) |
      (this.diags2 & (1 << this.row - col + this.size - 1))) == 0;
  }

  Board place(int col) {
    Board result = new Board(this.size);
    result.row = this.row + 1;
    result.cols = this.cols | 1 << col;
    result.diags1 = this.diags1 | 1 << (this.row + col);
    result.diags2 = this.diags2 | 1 << (this.row - col + this.size - 1);
    return result;
  }

  int solve() {
    if (this.row == this.size) {
      return 1;
    }
    else {
      int result = 0;
      for (int col = 0; col < this.size; col++) {
        if (ok(col)) {
          result += place(col).solve();
        }
      }
      return result;
    }
  }
}

main(List<String> args) {
  int from = args.length >= 1 ? int.parse(args[0]) : 8;
  int to = args.length >= 2 ? int.parse(args[1]) : from;
  for (int size = from; size <= to; size++) {
    var stopwatch = new Stopwatch();
    stopwatch.start();
    Board board = new Board(size);
    int result = board.solve();
    var elapsed = stopwatch.elapsedMilliseconds / 1000;
    print("${size},${result},${elapsed}");
  }
}
