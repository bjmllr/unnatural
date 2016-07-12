unless RUBY_ENGINE == 'jruby'
  require 'unnatural/fast_compare'

  module Unnatural
    module Fast
      def self.sort(enumerable)
        enumerable.sort { |a, b| compare(a, b) }
      end
    end
  end

  Unnatural.algorithm ||= Unnatural::Fast
end
