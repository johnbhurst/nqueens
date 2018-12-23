# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-03-23

require 'time'

class Board
  def initialize(size, row = 0, cols = 0, diags1 = 0, diags2 = 0)
    @size = size
    @row = row
    @cols = cols
    @diags1 = diags1
    @diags2 = diags2
  end

  def ok(col)
    @cols & (1 << col) |
    @diags1 & (1 << @row+col) |
    @diags2 & (1 << @row-col+@size-1) == 0
  end

  def place(col)
    Board.new(@size,
    @row+1,
    @cols | (1 << col),
    @diags1 | (1 << @row+col),
    @diags2 | (1 << @row-col+@size-1) )
  end

  def solve
    @row == @size ? 1 :
    (0...@size).map {|col| ok(col) ? place(col).solve : 0}.reduce(:+)
  end
end

from = ARGV ? ARGV.shift.to_i : 8
to = ARGV ? ARGV.shift.to_i : from

from.upto(to) do |size|
  start = Time::now
  solutions = Board.new(size).solve
  duration = (Time::now - start).to_f
  puts "#{size},#{solutions},#{sprintf("%0.3f", duration)}"
end
