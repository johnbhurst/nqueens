// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

using System;
using System.Diagnostics;

class Queens {

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
      string elapsed = String.Format("{0:00}:{1:00}:{2:00}.{3:000}", ts.Hours, ts.Minutes, ts.Seconds, ts.Milliseconds);
      Console.WriteLine("Board size " + size + " has " + count + " solutions. Calculated in " + elapsed + ".");
    }
  }
}

class Board {
  private int size;
  private int row;
  private long cols;
  private long diags1;
  private long diags2;

  public Board(int size) {
    this.size = size;
  }

  private Board Place(int col) {
    Board result = new Board(this.size);
    result.row = this.row + 1;
    result.cols = this.cols | ((uint) 1) << col;
    result.diags1 = this.diags1 | ((uint) 1) << (this.row + col);
    result.diags2 = this.diags2 | ((uint) 1) << (this.row - col + this.size - 1);
    return result;
  }

  private Boolean Ok(int col) {
    return ((this.cols & (1 << col)) |
      (this.diags1 & (1 << this.row + col)) |
      (this.diags2 & (1 << this.row - col + this.size - 1))) == 0;
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
