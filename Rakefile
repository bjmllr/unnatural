require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

require 'rake/extensiontask'
spec = Gem::Specification.load('unnatural.gemspec')
Rake::ExtensionTask.new do |ext|
  ext.name = 'fast_compare'
  ext.ext_dir = 'ext/unnatural'
  ext.lib_dir = 'lib/unnatural'
  ext.gem_spec = spec
end

task :benchmark do
  require './test/benchmark.rb'
end

if RUBY_ENGINE == 'jruby'
  task default: :test
else
  task default: [:compile, :test]
end
