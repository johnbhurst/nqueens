# Copyright 2018 John Hurst
# JOhn Hurst (john.b.hurst@gmail.com)
# 2018-12-22

defmodule QueensHalf do
  def solve(board) do
    # solve for half the columns on first row, double result for symmetry
    half_cols = 0..div(board.size, 2)-1
      |> Enum.map(fn col -> 2 * Queens.solve(Queens.place(board, col)) end)
      |> Enum.sum
    # add middle column if odd number
    extra_col = if rem(board.size, 2) == 0, do: 0, else: Queens.solve(Queens.place(board, div(board.size, 2)))
    half_cols + extra_col
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
