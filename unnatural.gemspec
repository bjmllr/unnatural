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

  spec.files         = `git ls-files -z`.split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files        += Dir.glob('ext/unnatural/*')
  spec.require_paths = ['lib']

  spec.extensions = ['ext/unnatural/Rakefile']

  spec.add_dependency 'ffi-compiler', '~> 1.0'
  spec.add_dependency 'rake', '>= 9', '< 12'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'benchmark-ips'
end
