require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task default: [:spec, :generative]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation --tag ~generative --order random'
end

RSpec::Core::RakeTask.new(:generative) do |t|
  ENV['GENERATIVE_COUNT'] ||= '10_000'
  t.rspec_opts = '--format Generative --tag generative'
end
