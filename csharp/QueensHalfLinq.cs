// Copyright 2017 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-30

using System;
using System.Diagnostics;
using System.Linq;

class Board {
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

  public int SolveRest() {
    return this.row == this.size ? 1 :
      Enumerable.Range(0, this.size)
        .Where(Ok)
        .Select(col => Place(col).SolveRest())
        .Sum();
  }

  public int Solve() {
    // solve for half the columns on first row, double result for symmetry
    return Enumerable.Range(0, this.size/2)
      .Select(col => 2 * Place(col).SolveRest())
      .Sum()
    // add middle column if odd number
    + (this.size % 2 == 1 ? Place(this.size/2).SolveRest() : 0);
  }
}

class QueensLinq {
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
