# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unnatural/version'

Gem::Specification.new do |spec|
  spec.name          = 'unnatural'
  spec.version       = Unnatural::VERSION
  spec.authors       = ['Ben Miller']
  spec.email         = ['bjmllr@gmail.com']

  spec.summary       = 'A natural sort.'
  spec.description   = 'A natural sort implementation with an emphasis on speed.'
  spec.homepage      = 'https://github.com/bjmllr/unnatural'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  unless RUBY_ENGINE == 'jruby'
    spec.extensions << 'ext/unnatural/extconf.rb'
  end

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rake-compiler', '~>0.9'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'benchmark-ips'
end
