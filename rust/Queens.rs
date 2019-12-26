// Copyright 2019 John Hurst
// John Hurst (john.b.hurst@gmail.com)
// 2019-12-26

use std::env;
use std::time::Instant;

struct Board {
  size: u8,
  row: u8,
  cols: u64,
  diags1: u64,
  diags2: u64,
}

fn new(size: u8) -> Board {
  return Board {
    size: size,
    row: 0u8,
    cols: 0u64,
    diags1: 0u64,
    diags2: 0u64,
  };
}

fn ok(board: &Board, col: u8) -> bool {
  return (board.cols & (1 << col)) == 0 &&
         (board.diags1 & (1 << (board.row + col))) == 0 &&
         (board.diags2 & (1 << (board.row + board.size - col - 1))) == 0;
}

fn place(board: &Board, col: u8) -> Board {
  return Board {
    size: board.size,
    row: board.row + 1,
    cols: board.cols | 1 << col,
    diags1: board.diags1 | 1 << (board.row + col),
    diags2: board.diags2 | 1 << (board.row + board.size - col - 1),
  };
}

fn solve(board: &Board) -> u64 {
  return if board.row == board.size {
    1
  }
  else {
    let mut result = 0u64;
    for col in 0..board.size {
      if ok(&board, col) {
        let new_board = place(&board, col);
        result += solve(&new_board);
      }
    }
    return result;
  }
}

fn main() {
  let args: Vec<String> = env::args().collect();
  let from: u8 = if args.len() >= 2 { args[1].parse().unwrap() } else { 8 };
  let to: u8 = if args.len() >= 3 { args[2].parse().unwrap() } else { from };

  for size in from..=to {
    let start = Instant::now();
    let board = new(size);
    let result = solve(&board);
    let elapsed = start.elapsed().as_millis() as f64 / 1000.0;
    println!("{},{},{}", size, result, elapsed);
  }
}
