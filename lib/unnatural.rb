require 'unnatural/version'

module Unnatural
  def self.algorithms
    [:Substitution, :Split, :Scan, :Fast]
      .select { |name| const_defined?(name) }
      .map { |name| const_get(name) }
  end

  def self.algorithm
    @algorithm
  end

  def self.algorithm=(mod)
    @algorithm = mod
  end

  def self.sort(enumerable)
    @algorithm.sort(enumerable)
  end

  def self.compare(a, b)
    @algorithm.compare(a, b)
  end

  def <=>(other)
    Unnatural.compare(to_str, other.to_str)
  end
end

require 'unnatural/fast'

Unnatural.algorithm ||= begin
                          require 'unnatural/substitution'
                          Unnatural::Substitution
                        end
