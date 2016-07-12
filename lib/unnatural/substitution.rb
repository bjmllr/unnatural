module Unnatural
  module Substitution
    def self.sort(enumerable)
      largest = enumerable.map(&:size).max
      enumerable.sort_by { |s| substitute(s, largest) }
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
