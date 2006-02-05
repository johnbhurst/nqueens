# $Id$
# John Hurst (jbhurst@attglobal.net)
#

class Board

  def initialize(size)
    @size = size
    @col = []
    size.times {@col.push(nil)}
  end

  def size
    @col.size
  end

  def place!(row, col)
    @col[row] = col
  end

  def unplace!(row)
    col = @col[row]
    @col[row] = nil
    col
  end

  def ok(row, col)
    (0..row-1).each do |r|
      return false if @col[r] == col
      return false if (col - @col[r]).abs == (row - r).abs
    end
  end

  def solve!
    row = 0
    col = 0
    while row < size
      while !ok(row, col) and col < size
        col += 1
      end
      if col < size
        place!(row, col)
        row += 1
        col = 0
      else
        row -= 1
        col = unplace!(row) + 1
      end
    end
    self
  end

  def printout
    (0..@size-1).each do |row|
      if @col[row]
        (@col[row]).times {print(" ")}
        puts "X"
      else
        puts ""
      end
    end
  end

end # class Board

size = ARGV.shift.to_i
Board.new(size).solve!.printout


