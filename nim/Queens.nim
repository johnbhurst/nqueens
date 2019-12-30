# Copyright 2019 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2019-12-27

import bitops
import os
import strutils
import times

type
  Board = object
    size: int
    row: int
    cols: uint64
    diags1: uint64
    diags2: uint64

proc new(size: int): Board =
  Board(size: size, row: 0, cols: 0'u64, diags1: 0'u64, diags2: 0'u64)

proc ok(board: Board, col: int): bool =
  ((board.cols and rotateLeftBits(1'u64, col)) or
   (board.diags1 and rotateLeftBits(1'u64, board.row + col)) or
   (board.diags2 and rotateLeftBits(1'u64, board.row - col + board.size - 1))) == 0

proc place(board: Board, col: int): Board =
  Board(
    size: board.size,
    row: board.row + 1,
    cols: board.cols or rotateLeftBits(1'u64, col),
    diags1: board.diags1 or rotateLeftBits(1'u64, board.row + col),
    diags2: board.diags2 or rotateLeftBits(1'u64, board.row - col + board.size - 1)
  )

proc solve(board: Board): int =
  if board.row == board.size:
    result = 1
  else:
    result = 0
    for col in countup(0, board.size - 1):
      if ok(board, col):
        result = result + solve(place(board, col))

var fr = if paramCount() >= 1: parseInt(paramStr(1)) else: 8
var to = if paramCount() >= 2: parseInt(paramStr(2)) else: fr

for size in countup(fr, to):
  var start = cpuTime()
  var result = solve(new(size))
  var elapsed = cpuTime() - start
  echo size, ',', result, ',', elapsed

