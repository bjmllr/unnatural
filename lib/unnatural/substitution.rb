module Unnatural
  # Compares strings by zero-padding integer sequences such that all are the
  # same length. Pure Ruby. Tends to be outperformed by `Unnatural::Scan` on
  # longer strings. Recommended for sorting short unicode strings.
  module Substitution
    def self.sort(enumerable)
      largest = enumerable.map(&:size).max
      enumerable.sort_by { |s| substitute(s, largest) }
    end

    def self.sort_by(enumerable)
      raise ArgumentError, 'Block expected but none given' unless block_given?
      largest = enumerable.map { |e| yield e }.map(&:size).max
      enumerable.sort_by { |s| substitute((yield s), largest) }
    end

    def self.compare(a, b)
      largest = a.size < b.size ? b.size : a.size
      substitute(a, largest) <=> substitute(b, largest)
    end

    def self.substitute(string, size)
      format_string = "%0#{size}d"
      string.downcase.gsub(/\d+/) do |m|
        format(format_string, m.gsub(/^0+(?=[1-9])/, ''))
      end
    end
  end
end
