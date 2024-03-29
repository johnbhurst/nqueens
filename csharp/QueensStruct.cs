// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-01-27

using System;
using System.Diagnostics;

struct Board {
  private int size;
  private int row;
  private long cols;
  private long diags1;
  private long diags2;

  public Board(int size) {
    this.size = size;
  }

  private Boolean Ok(int col) {
    return ((this.cols & (1 << col)) |
      (this.diags1 & (1 << this.row + col)) |
      (this.diags2 & (1 << this.row - col + this.size - 1))) == 0;
  }

  private Board Place(int col) {
    Board result = new Board(this.size);
    result.row = this.row + 1;
    result.cols = this.cols | ((uint) 1) << col;
    result.diags1 = this.diags1 | ((uint) 1) << (this.row + col);
    result.diags2 = this.diags2 | ((uint) 1) << (this.row - col + this.size - 1);
    return result;
  }

  public int Solve() {
    if (this.row == this.size) {
      return 1;
    }
    else {
      int result = 0;
      for (int col = 0; col < this.size; col++) {
        if (Ok(col)) {
          result += Place(col).Solve();
        }
      }
      return result;
    }
  }
}

class QueensStruct {
  static void Main(string[] args) {
    Int32 from = args.Length >= 1 ? Int32.Parse(args[0]) : 8;
    Int32 to = args.Length >= 2 ? Int32.Parse(args[1]) : from;

    for (int size = from; size <= to; size++) {
      Stopwatch watch = new Stopwatch();
      watch.Start();
      Board board = new Board(size);
      int count = board.Solve();
      watch.Stop();
      TimeSpan ts = watch.Elapsed;
      double elapsed = ts.Hours*3600.0 + ts.Minutes*60.0 + ts.Seconds + ts.Milliseconds/1000.0;
      Console.WriteLine(String.Format("{0:0},{1:0},{2:0.000}", size, count, elapsed));
    }
  }
}
