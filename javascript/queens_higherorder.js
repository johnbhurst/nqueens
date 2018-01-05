// Copyright 2017 John hurst
// John Hurst (john.b.hurst@gmail.com)
// 2017-12-16

// This version uses ES6's filter(), map() & reduce() and higher-order functions to count solutions more elegantly.
// But, this version runs about 20 times slower than queens_func.js with a plain old for-loop and regular functions.

function new_board(size) {
  return {
    size: size,
    places: 0,
    col: 0,
    diag1: 0,
    diag2: 0,
  }
}

function solve_board(board) {
  if (board.places == board.size) {
    return 1
  }
  else {
    var row = board.places
    var ok = function(col) {
      return (board.col & (1 << col)) == 0 &&
             (board.diag1 & (1 << row + col)) == 0 &&
             (board.diag2 & (1 << row - col + board.size - 1)) == 0
    }
    var place = function(col) {
      return {
        size: board.size,
        places: board.places + 1,
        col: board.col | 1 << col,
        diag1: board.diag1 | 1 << (row + col),
        diag2: board.diag2 | 1 << (row - col + board.size - 1)
      }
    }
    var sum = (v1, v2) => v1 + v2
    return Array.from(Array(board.size).keys())
      .filter(ok)
      .map(place)
      .map(solve_board)
      .reduce(sum, 0)
  }
  return result
}

var start = Number.parseInt(process.argv[2])
var end = process.argv.length > 3 ?
  Number.parseInt(process.argv[3]) : start

for (var size = start; size <= end; size++) {
  console.time(size)
  var result = solve_board(new_board(size))
  console.timeEnd(size)
  console.log(result)
}
