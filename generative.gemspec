# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'generative'
  gem.version       = '0.1.0'
  gem.authors       = ["Justin Campbell",          "Dan McClory"]
  gem.email         = ["justin@justincampbell.me", "danmcclory@gmail.com"]
  gem.description   = "Generative testing for RSpec"
  gem.summary       = "Generative testing for RSpec"
  gem.homepage      = "https://github.com/justincampbell/generative"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |file| File.basename file }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  case ENV['RSPEC_VERSION']
  when '2'
    gem.add_dependency 'rspec', '~> 2.0'
  when '3'
    gem.add_dependency 'rspec', '3.0.0.beta1'
  else
    gem.add_dependency 'rspec'
  end

  gem.add_development_dependency 'rake'
end
