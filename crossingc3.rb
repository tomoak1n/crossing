#!/usr/bin/env ruby

class CrossCounter
  def initialize(nnodes)
    @tdepth = 0
    while(nnodes >0)
      @tdepth += 1
      nnodes >>= 1
    end
    @arys = Array.new
    (0..@tdepth).each do |i|
      @arys[i]=Array.new(1<<i, 0)
    end
  end
  def registerandreportcrosses(number)
    cross = 0
    i = @tdepth
    sn = number
    while i >= 0
      if (sn&1) == 0
        sn >>= 1
        cross += @arys[i][sn]
      else
        sn >>= 1
        @arys[i][sn] += 1
      end
      i -= 1
    end
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

