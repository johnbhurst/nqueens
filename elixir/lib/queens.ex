# Copyright 2018 John Hurst
# JOhn Hurst (john.b.hurst@gmail.com)
# 2018-12-22

defmodule Queens do
  use Bitwise

  def ok(board, col) do
    (board.cols &&& (1 <<< col)) == 0 and
    (board.diags1 &&& (1 <<< board.row + col)) == 0 and
    (board.diags2 &&& (1 <<< board.row - col + board.size - 1)) == 0
  end

  def place(board, col) do
    %Board{
      size: board.size,
      row: board.row + 1,
      cols: board.cols ||| (1 <<< col),
      diags1: board.diags1 ||| (1 <<< board.row + col),
      diags2: board.diags2 ||| (1 <<< board.row - col + board.size - 1)
    }
  end

  def solve(board) do
    if board.row == board.size, do: 1, else: 1..board.size
      |> Enum.filter(fn col -> ok(board, col) end)
      |> Enum.map(fn col -> solve(place(board, col)) end)
      |> Enum.sum
  end

  def main(argv) do
    from = if length(argv) > 0, do: String.to_integer(Enum.at(argv, 0)), else: 8
    to = if length(argv) > 1, do: String.to_integer(Enum.at(argv, 1)), else: from
    for size <- from..to do
      start = Time.utc_now
      result = solve(%Board{size: size})
      duration = Time.diff(Time.utc_now, start, 1000)/1000
      IO.puts "#{size},#{result},#{duration}"
    end
  end
end
