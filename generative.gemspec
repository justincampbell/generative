# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

authors = {
  "Justin Campbell" => "justin@justincampbell.com",
  "Dan McClory" => "danmcclory@gmail.com",
  "Nate West" => "natescott.west@gmail.com"
}

Gem::Specification.new do |gem|
  gem.name          = 'generative'
  gem.version       = '0.2.5'
  gem.authors       = authors.keys
  gem.email         = authors.values
  gem.description   = "Generative and property-based testing for RSpec"
  gem.summary       = "Generative and property-based testing for RSpec"
  gem.homepage      = "https://github.com/justincampbell/generative"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |file| File.basename file }
  gem.require_paths = ["lib"]

  gem.add_dependency 'rspec', '>= 3.0'

  gem.add_development_dependency 'rake'
end
