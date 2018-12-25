// Copyright 2018 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2018-08-19

import Foundation

class Board {
  let size, row, cols, diags1, diags2: Int
  init(size: Int, row: Int, cols: Int, diags1: Int, diags2: Int) {
    self.size = size
    self.row = row
    self.cols = cols
    self.diags1 = diags1
    self.diags2 = diags2
  }

  func place(col: Int) -> Board {
    return Board(size: size,
      row: self.row + 1,
      cols: self.cols | (1 << col),
      diags1: self.diags1 | (1 << (self.row + col)),
      diags2: self.diags2 | (1 << (self.row - col + self.size - 1)))
  }

  func ok(col: Int) -> Bool {
    let result = (self.cols & (1 << col)) == 0 &&
           (self.diags1 & (1 << (self.row + col))) == 0 &&
           (self.diags2 & (1 << (self.row - col + self.size - 1))) == 0
    return result
  }

  func solve() -> Int {
    return self.row == self.size ? 1 :
      (0..<self.size)
        .filter {self.ok(col: $0)}
        .map {self.place(col: $0).solve()}
        .reduce(0, +)
  }
}

let from = CommandLine.arguments.count > 1 ? Int(CommandLine.arguments[1])! : 8
let to = CommandLine.arguments.count > 2 ? Int(CommandLine.arguments[2])! : from


for size in from...to {
  let startTime = Date.init()
  let solutions = Board(size: size, row: 0, cols: 0, diags1: 0, diags2: 0).solve()
  let duration = Date.init().timeIntervalSince(startTime)
  print(String(format: "%d,%d,%.3f", size, solutions, duration))
}
