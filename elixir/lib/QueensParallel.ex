# Copyright 2018 John Hurst
# JOhn Hurst (john.b.hurst@gmail.com)
# 2018-12-22

defmodule QueensParallel do
  def solve_main(board) do
    1..board.size
      |> Enum.map(fn col -> Task.async(Queens, :solve, [Queens.place(board, col)]) end)
      |> Enum.map(fn task -> Task.await(task, 10 * 60 * 60 * 1000) end)
      |> Enum.sum
  end

  def main(argv) do
    from = if length(argv) > 0, do: String.to_integer(Enum.at(argv, 0)), else: 8
    to = if length(argv) > 1, do: String.to_integer(Enum.at(argv, 1)), else: from
    for size <- from..to do
      start = Time.utc_now
      result = solve_main(%Board{size: size})
      duration = Time.diff(Time.utc_now, start, 1000)/1000
      IO.puts "#{size},#{result},#{duration}"
    end
  end
end
