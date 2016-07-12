unless RUBY_ENGINE == 'jruby'
  require 'unnatural/fast_compare'

  module Unnatural
    module Fast
      def self.sort(enumerable)
        enumerable.sort { |a, b| compare(a, b) }
      end

      def self.sort_by(enumerable)
        raise ArgumentError, "Block expected but none given" unless block_given?
        enumerable
          .map { |e| [(yield e), e] }
          .sort { |a, b| compare(a, b) }
          .map { |ary| ary[1] }
      end
    end
  end

  Unnatural.algorithm ||= Unnatural::Fast
end
