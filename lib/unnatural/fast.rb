require 'ffi'
require 'ffi-compiler/loader'

module Unnatural
  module Fast
    module Ext
      extend FFI::Library
      ffi_lib FFI::Compiler::Loader.find('unnatural_ext')
      attach_function :compare, [:string, :int, :string, :int], :int
    end

    def self.compare(a, b)
      Ext.compare(a, a.size, b, b.size)
    end

    def self.sort(enumerable)
      enumerable.sort { |a, b| compare(a, b) }
    end

    def self.sort_by(enumerable)
      raise ArgumentError, 'Block expected but none given' unless block_given?
      enumerable
        .map { |e| [(yield e), e] }
        .sort { |a, b| compare(a.first, b.first) }
        .map { |ary| ary[1] }
    end
  end
end

Unnatural.algorithm ||= Unnatural::Fast
