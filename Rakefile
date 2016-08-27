require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rake/testtask'

require 'rake'
require 'rake/clean'

require 'ffi'
require 'ffi-compiler/compile_task'

CLEAN.include('ext/unnatural/*{.o,.log,.so,.bundle}')
CLEAN.include('lib/**/*{.o,.log,.so,.bundle}')

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'FFI compiler'
namespace 'ffi-compiler' do
  FFI::Compiler::CompileTask.new('ext/unnatural/unnatural_ext')
end
task compile_ffi: ['ffi-compiler:default']

task default: [:clean, :compile_ffi, :test]
