# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'generative'
  gem.version       = '0.0.1'
  gem.authors       = ["Justin Campbell"]
  gem.email         = ["justin@justincampbell.me"]
  gem.description   = "Generative testing for RSpec"
  gem.summary       = "Generative testing for RSpec"
  gem.homepage      = "https://github.com/justincampbell/generative"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rspec', '3.0.0.beta1'

  gem.add_development_dependency 'rake'
end
