#!/usr/bin/env ruby

class CrossCounter
  def initialize(nnodes)
    @tdepth = Math::log2(nnodes).to_i 
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
      t = sn >> 1
      a = @arys[i]
      if (sn&1) == 0
        cross += a[t]
      else
        a[t] += 1
      end
      sn = t
      i -= 1
    end
    cross
  end
end

fsize = File::Stat.new(ARGV[0]).size
maxsizeest = fsize/Math::log10(fsize).to_i

counter = CrossCounter.new(maxsizeest)
cross = 0
ARGF.each_line do |line|
  cross += counter.registerandreportcrosses(line.to_i)  
end
puts cross

