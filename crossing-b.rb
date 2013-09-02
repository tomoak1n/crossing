#!/usr/bin/env ruby

class CrossCounter
  def initialize(nnodes)
    @tdepth = Math::log2(nnodes).to_i + 1
    @arys = Array.new
    (0...@tdepth).each do |i|
      @arys[i]=Array.new(2<<i, 0)
    end
  end
  def dumpstatus
    p @arys
  end
  def registerandreportcrosses(number)
    i = @tdepth
    while i > 0
      i -= 1
      @arys[i][number >> (@tdepth - i - 1)] += 1
    end
#    self.dumpstatus
    index = @arys[@tdepth - 1].size-1
    cross = 0
#    while index > number
#      cross += @arys[@tdepth -1][index]
#      index -= 1
#    end
    i = @tdepth
    while i > 0
      i -= 1
      if (number >> (@tdepth - i - 1))&1 == 0
        cross += 
          @arys[i][(number >> (@tdepth - i - 1)) + 1]
      end
    end
#    p number,cross
    cross
  end
end

idata = Array.new
ARGF.each_line do |line|
  idata << line.to_i
end

cross = 0
counter = CrossCounter.new(idata.size)
idata.each do |number|
  cross += counter.registerandreportcrosses(number)  
end
puts cross

