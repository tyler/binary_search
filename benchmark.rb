require 'benchmark'
require 'rubygems'

require 'binary_search/pure'

def bench(arr_size, range, iterations, type)
  arr = Array.new(arr_size).map { |n| rand(range) }.sort

  puts "Benchmark for #{iterations} iterations searching through an array of #{arr_size} elements."
  Benchmark.bm(12) do |b|
    b.report('Index:') do
      iterations.times { arr.index(rand(range)) }
    end
    b.report("#{type} BI:") do
      iterations.times { arr.binary_index(rand(range)) }
    end
  end
  puts
end

def bench_block(arr_size, range, iterations, type)
  arr = Array.new(arr_size).map { |n| rand(range) }.sort

  puts "Benchmark for #{iterations} iterations searching through an array of #{arr_size} elements (with block)."
  Benchmark.bm(12) do |b|
    b.report('Index:') do
      iterations.times { arr.index(rand(range)) }
    end
    b.report("#{type} BI:") do
      target = rand(range)
      iterations.times { arr.binary_index { |x| target <=> x } }
    end
  end
  puts
end

puts '== Benchmark Ruby\'s builtin :index method vs. a pure Ruby binary search method'

bench 5, 10, 2000000, 'Ruby'
bench 10, 20, 1000000, 'Ruby'
bench 100, 200, 1000000, 'Ruby'
bench 1000, 2000, 100000, 'Ruby'
bench 10000, 20000, 10000, 'Ruby'
bench 100000, 200000, 1000, 'Ruby'

puts '== Benchmark Ruby\'s builtin :index method vs. a pure Ruby binary search method (with block)'

bench_block 5, 10, 2000000, 'Ruby'
bench_block 10, 20, 1000000, 'Ruby'
bench_block 100, 200, 1000000, 'Ruby'
bench_block 1000, 2000, 100000, 'Ruby'
bench_block 10000, 20000, 10000, 'Ruby'
bench_block 100000, 200000, 1000, 'Ruby'

require 'binary_search/native'

puts '== Benchmark Ruby\'s builtin :index method vs. a native binary search method'

bench 5, 10, 2000000, 'Native'
bench 10, 20, 1000000, 'Native'
bench 100, 200, 1000000, 'Native'
bench 1000, 2000, 100000, 'Native'
bench 10000, 20000, 10000, 'Native'
bench 100000, 200000, 1000, 'Native'

puts '== Benchmark Ruby\'s builtin :index method vs. a native binary search method (with block)'

bench_block 5, 10, 2000000, 'Ruby'
bench_block 10, 20, 1000000, 'Ruby'
bench_block 100, 200, 1000000, 'Ruby'
bench_block 1000, 2000, 100000, 'Ruby'
bench_block 10000, 20000, 10000, 'Ruby'
bench_block 100000, 200000, 1000, 'Ruby'
