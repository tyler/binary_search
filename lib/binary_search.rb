class Array
  def binary_index(target,lower=0,upper=self.size-1)
    return if lower > upper
    idx = lower + (upper - lower) / 2
    value = self[idx]
    if value == target
      return idx
    elsif value > target
      self.binary_index(target, lower, idx - 1)
    elsif value < target
      self.binary_index(target, idx + 1, upper)
    end
  end
end


if $0 == __FILE__
  require 'benchmark'

  def bench(arr_size, range, iterations)
    arr = Array.new(arr_size).map { |n| rand(range) }.sort

    puts "Benchmark for #{iterations} iterations searching through an array of #{arr_size} elements."
    Benchmark.bm(15) do |b|
      b.report('index:') do
        iterations.times { arr.index(rand(range)) }
      end
      b.report('binary_index:') do
        iterations.times { arr.binary_index(rand(range)) }
      end
    end
    puts
  end

  bench 100, 200, 1000000
  bench 1000, 2000, 100000
  bench 10000, 20000, 10000
  bench 100000, 200000, 1000
  bench 1000000, 2000000, 100
  bench 10000000, 20000000, 10
end
