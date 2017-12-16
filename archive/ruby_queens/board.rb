# $Id: board.rb 664 2007-03-28 08:00:36Z jhurst $
# Copyright 2007 John Hurst
# John Hurst (jbhurst@attglobal.net)
# 2007-03-27 

class Board

  def initialize(size)
    @pos = Array.new(size, nil)
    @col = Array.new(size, false)
    @diag1 = Array.new(2*size, false)
    @diag2 = Array.new(2*size, false)
  end

  def size
    @pos.size
  end

  def col(row)
    @pos[row]
  end

  def place!(row, col)
    @pos[row] = col
    @col[col] = true
    @diag1[col-row+size] = true
    @diag2[col+row] = true
  end

  def unplace!(row)
    col = @pos[row]
    @pos[row] = nil
    @col[col] = false
    @diag1[col-row+size] = false
    @diag2[col+row] = false
    col
  end

  def ok?(row, col)
    return false if @col[col]
    return false if @diag1[col-row+size]
    return false if @diag2[col+row]
    true
  end

  def solve!
    row = 0
    col = 0
    while row >= 0 and row < size
      while col < size and !ok?(row, col)
        col += 1
      end
      if col < size
        place!(row, col)
        row += 1
        col = 0
      else
        row -= 1
        if row >= 0
          col = unplace!(row) + 1
        end
      end
    end
    return row == size
  end

  def printout
    @pos.each {|p| puts " " * p + "X"}
  end

end # class Board

