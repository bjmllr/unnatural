require 'strscan'

module Unnatural
  # Compares strings using a `StringScanner`. Pure ruby. Tends to be
  # outperformed by `Unnatural::Substitution` and `Unnatural::Split` when
  # sorting short strings via the global sort function, but its comparison
  # function is the fastest of the pure-ruby algorithms.
  module Scan
    def self.sort(enumerable)
      enumerable.sort { |a, b| compare(a, b) }
    end

    def self.sort_by(enumerable)
      raise ArgumentError, 'Block expected but none given' unless block_given?
      enumerable
        .map { |e| [(yield e), e] }
        .sort { |a, b| compare(a, b) }
        .map { |ary| ary[1] }
    end

    # rubocop: disable Metrics/AbcSize
    # rubocop: disable Metrics/CyclomaticComplexity
    # rubocop: disable Metrics/MethodLength
    # rubocop: disable Metrics/PerceivedComplexity
    def self.compare(a_string, b_string)
      if a_string.is_a?(Array) && b_string.is_a?(Array)
        a_string = a_string.first
        b_string = b_string.first
      end

      a = StringScanner.new(a_string)
      b = StringScanner.new(b_string)

      loop do
        a_number = a.scan(/\d+/)
        b_number = b.scan(/\d+/)

        if a_number.nil? && b_number.nil?
        # move on
        elsif a_number.nil?
          return +1
        elsif b_number.nil?
          return -1
        else
          compare = a_number.to_i <=> b_number.to_i
          return compare unless compare == 0
        end

        a_segment = a.scan(/\D+/)
        b_segment = b.scan(/\D+/)

        if a_segment.nil? && b_segment.nil?
        # move on
        elsif a_segment.nil?
          return -1
        elsif b_segment.nil?
          return +1
        else
          compare = a_segment.casecmp(b_segment)
          return compare unless compare == 0
        end

        return 0 if a.eos? && b.eos?
        return -1 if a.eos?
        return +1 if b.eos?
      end
    end
    # rubocop: enable Metrics/AbcSize
    # rubocop: enable Metrics/CyclomaticComplexity
    # rubocop: enable Metrics/MethodLength
    # rubocop: enable Metrics/PerceivedComplexity
  end
end
