require 'benchmark/ips'
require 'unnatural'
require 'unnatural/fast'
require 'unnatural/scan'
require 'unnatural/split'
require 'unnatural/substitution'

seed = ENV['RANDOM_SEED'] || rand(1..100_000)
puts "Random seed is #{seed} (RANDOM_SEED=#{seed} ruby benchmark.rb)"
srand seed.to_i

characters = (' '..'~').to_a
strings = Array.new(10) { Array.new(10) { characters.sample }.join }
pairs = strings.combination(2)

puts 'Measuring .sort'
Benchmark.ips do |t|
  t.report('substitution') { Unnatural::Substitution.sort(strings) }
  t.report('split') { Unnatural::Split.sort(strings) }
  t.report('scan') { Unnatural::Scan.sort(strings) }
  t.report('fast') { Unnatural::Fast.sort(strings) }

  t.compare!
end

puts 'Measuring .compare'
Benchmark.ips do |t|
  t.report('substitution') do
    pairs.each do |a, b|
      Unnatural::Substitution.compare(a, b)
    end
  end

  t.report('split') do
    pairs.each do |a, b|
      Unnatural::Split.compare(a, b)
    end
  end

  t.report('scan') do
    pairs.each do |a, b|
      Unnatural::Scan.compare(a, b)
    end
  end

  unless RUBY_ENGINE == 'jruby'
    t.report('fast') do
      pairs.each do |a, b|
        Unnatural::Fast.compare(a, b)
      end
    end
  end

  t.compare!
end
