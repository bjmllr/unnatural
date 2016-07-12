module Unnatural
  module Split
    SPLITTER = /(?<=\d)(?=\D)|(?<=\D)(?=\d)/
    PRED = ['0'.ord.pred.chr].freeze

    def self.sort(enumerable)
      enumerable.sort_by { |s| split(s) }
    end

    def self.sort_by(enumerable)
      raise ArgumentError, "Block expected but none given" unless block_given?
      enumerable.sort_by { |s| split(yield s) }
    end

    def self.compare(a, b)
      split(a) <=> split(b)
    end

    def self.split(string)
      array = string.downcase.split(SPLITTER)
      array = PRED + array if ('0'..'9').cover?(array[0])
      array.map.with_index { |e, i| i.odd? ? e.to_i : e }
    end
  end
end
