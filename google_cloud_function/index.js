/**
 * Copyright 2018 John Hurst
 * John Hurst (john.b.hurst@gmail.com)
 * 2018-01-08
 *
 * HTTP Cloud Function.
 *
 * @param {Object} req Cloud Function request context.
 * @param {Object} res Cloud Function response context.
 */
exports.queensGET = function queensGET(req, res) {
  var ok = function(board, col) {
    return (board.cols & (1 << col)) == 0 &&
      (board.diags1 & (1 << board.row + col)) == 0 &&
      (board.diags2 & (1 << board.row - col + board.size - 1)) == 0
  }

  var place = function(board, col) {
    return {
      size: board.size,
      row: board.row + 1,
      cols: board.cols | 1 << col,
      diags1: board.diags1 | 1 << (board.row + col),
      diags2: board.diags2 | 1 << (board.row - col + board.size - 1)
    }
  }

  var solve_board = function(board) {
    if (board.row == board.size) {
      return 1
    }
    else {
      var result = 0
      for (var col = 0; col < board.size; col++) {
        if (ok(board, col)) {
          result += solve_board(place(board, col))
        }
      }
    }
    return result
  }

  var board = {
    size:   req.query.size   ? Number.parseInt(req.query.size)   : 4,
    row:    req.query.row    ? Number.parseInt(req.query.row)    : 0,
    cols:   req.query.cols   ? Number.parseInt(req.query.cols)   : 0,
    diags1: req.query.diags1 ? Number.parseInt(req.query.diags1) : 0,
    diags2: req.query.diags2 ? Number.parseInt(req.query.diags2) : 0
  }
  res.send("" + solve_board(board))
};

