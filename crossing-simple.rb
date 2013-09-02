#!/usr/bin/env ruby

class CrossCounter
  def initialize
    @ary = Array.new
  end
  def registerandreportcrosses(number)
    index = @ary.size-1
    cross = 0
    while index >= 0 && @ary[index] > number
      cross += 1
      index -= 1
    end
    @ary.insert(index + 1, number);
    cross
  end
end
cross = 0
counter = CrossCounter.new
ARGF.each_line do |line|
  number = line.to_i
  cross += counter.registerandreportcrosses(number)  
end
puts cross

