# $Id: test_board.rb 664 2007-03-28 08:00:36Z jhurst $
# Copyright 2007 John Hurst
# John Hurst (jbhurst@attglobal.net)
# 2007-03-27 

require 'test/unit'
require 'board'

class TestBoard < Test::Unit::TestCase
  def test_create
    Board.new(1)
    Board.new(2)
    Board.new(3)
    Board.new(4)
    Board.new(20)
    assert(true)
  end

  def test_size
    b = Board.new(1)
    assert_equal(1, b.size)
    b = Board.new(4)
    assert_equal(4, b.size)
    b = Board.new(20)
    assert_equal(20, b.size)
  end

  def test_place
    b = Board.new(4)
    assert_equal(nil, b.col(0))
    assert_equal(nil, b.col(1))
    assert_equal(nil, b.col(2))
    assert_equal(nil, b.col(3))
    b.place!(0, 1)
    b.place!(1, 3)
    b.place!(2, 0)
    b.place!(3, 2)
    assert_equal(1, b.col(0))
    assert_equal(3, b.col(1))
    assert_equal(0, b.col(2))
    assert_equal(2, b.col(3))
  end

  def test_unplace
    b = Board.new(4)
    b.place!(0, 1)
    assert(!b.ok?(1, 1))
    assert(!b.ok?(0, 1))
    assert(!b.ok?(2, 3))
    b.unplace!(0)
    assert(b.ok?(1, 1))
    assert(b.ok?(0, 1))
    assert(b.ok?(2, 3))

    b.place!(1, 3)
    b.place!(2, 0)
    b.place!(3, 2)
    assert_equal(3, b.unplace!(1))
    assert_equal(nil, b.col(1))
    assert_equal(2, b.unplace!(3))
    assert_equal(nil, b.col(3))
  end

  def test_ok
    b = Board.new(4)
    assert( b.ok?(0, 0)); assert( b.ok?(0, 1)); assert( b.ok?(0, 2)); assert( b.ok?(0, 3));
    assert( b.ok?(1, 0)); assert( b.ok?(1, 1)); assert( b.ok?(1, 2)); assert( b.ok?(1, 3));
    assert( b.ok?(2, 0)); assert( b.ok?(2, 1)); assert( b.ok?(2, 2)); assert( b.ok?(2, 3));
    assert( b.ok?(3, 0)); assert( b.ok?(3, 1)); assert( b.ok?(3, 2)); assert( b.ok?(3, 3));
    b.place!(0, 1);
    assert(!b.ok?(1, 0)); assert(!b.ok?(1, 1)); assert(!b.ok?(1, 2)); assert( b.ok?(1, 3));
    assert( b.ok?(2, 0)); assert(!b.ok?(2, 1)); assert( b.ok?(2, 2)); assert(!b.ok?(2, 3));
    assert( b.ok?(3, 0)); assert(!b.ok?(3, 1)); assert( b.ok?(3, 2)); assert( b.ok?(3, 3));
    b.place!(1, 3);
    assert( b.ok?(2, 0)); assert(!b.ok?(2, 1)); assert(!b.ok?(2, 2)); assert(!b.ok?(2, 3));
    assert( b.ok?(3, 0)); assert(!b.ok?(3, 1)); assert( b.ok?(3, 2)); assert(!b.ok?(3, 3));
    b.place!(2, 0);
    assert(!b.ok?(3, 0)); assert(!b.ok?(3, 1)); assert( b.ok?(3, 2)); assert(!b.ok?(3, 3));
  end

  def test_solve_false
    b = Board.new(3)
    assert(!b.solve!)
  end

  def test_solve_true
    b = Board.new(4)
    assert(b.solve!)
    assert_equal(1, b.col(0))
    assert_equal(3, b.col(1))
    assert_equal(0, b.col(2))
    assert_equal(2, b.col(3))
  end

end
