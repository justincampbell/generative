require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

ENV['GENERATIVE_COUNT'] = '10_000'

task default: [:spec, :generative]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation --tag ~generative'
end

RSpec::Core::RakeTask.new(:generative) do |t|
  t.rspec_opts = '--format Generative --tag generative'
end
