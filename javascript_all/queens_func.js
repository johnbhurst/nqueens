// Copyright 2017 John hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-16


function place(board, row, col) {
  return {
    size: board.size,
    places: board.places + 1,
    col: board.col | 1 << col,
    diag1: board.diag1 | 1 << (row + col),
    diag2: board.diag2 | 1 << (row - col + board.size - 1)
  }
}

function ok(board, row, col) {
  return (board.col & (1 << col)) == 0 &&
         (board.diag1 & (1 << row + col)) == 0 &&
         (board.diag2 & (1 << row - col + board.size - 1)) == 0
}

function solve_board(board) {
  if (board.places == board.size) {
    return 1
  }
  else {
    var result = 0
    var row = board.places
    for (var col = 0; col < board.size; col++) {
      if (ok(board, row, col)) {
        result += solve_board(place(board, row, col))
      }
    }
  }
  return result
}

function solve(size) {
  return solve_board({size: size, places: 0, col: 0, diag1: 0, diag2: 0})
}

var start = Number.parseInt(process.argv[2])
var end = process.argv.length > 3 ?
  Number.parseInt(process.argv[3]) : start

for (var size = start; size <= end; size++) {
  console.time(size);
  var result = solve(size)
  console.timeEnd(size)
  console.log(result)
}
