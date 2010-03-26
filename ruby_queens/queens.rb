# $Id: queens.rb 664 2007-03-28 08:00:36Z jhurst $
# Copyright 2007 John Hurst
# John Hurst (jbhurst@attglobal.net)
# 2007-03-27 

require 'board'

size = ARGV.shift.to_i
b = Board.new(size)
start = Time.new
if b.solve!
  elapsed = Time.new - start
  b.printout
  puts "#{elapsed} seconds."
end
