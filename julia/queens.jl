# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-03-30

struct Board
  size::Int
  row::Int
  cols::Int
  diags1::Int
  diags2::Int
end

function new(size)
  Board(size, 0, 0, 0, 0)
end

function place(board::Board, col::Int)
  Board(
    board.size,
    board.row+1,
    board.cols | (1 << col),
    board.diags1 | (1 << (board.row + col)),
    board.diags2 | (1 << (board.row - col + board.size - 1))
  )
end

function ok(board::Board, col::Int)
  board.cols & (1 << col) |
    board.diags1 & (1 << (board.row + col)) |
    board.diags2 & (1 << (board.row - col + board.size - 1)) == 0
end

function solve(board::Board)
  board.row == board.size ? 1 :
  sum(map(col -> ok(board, col) ? solve(place(board, col)) : 0, 0:board.size-1))
end

