# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coordinates/version'

Gem::Specification.new do |spec|
  spec.name          = 'coordinates'
  spec.version       = Coordinates::VERSION
  spec.authors       = ['Kryptykfysh']
  spec.email         = ['kryptykfysh@kryptykfysh.co.uk']

  spec.summary       = %q{A set of libraries for conveting and expressing coordinate systems.}
  spec.description   = File.read('README.md')
  spec.homepage      = 'https://github.com/kryptykfysh/coordinates'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }.reject { |f| f =~ /.*\.gem\z/ }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.5', '>= 4.5.0'
  spec.add_development_dependency 'libnotify'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
