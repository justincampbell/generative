require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'generative/rake_task'

task default: [:spec, :generative, :acceptance]

RSpec::Core::RakeTask.new(:spec)
Generative::RakeTask.new(:generative)

desc "Verify all spec commands behave properly"
task :acceptance do
  [
    ['rspec', '6'],
    ['rake spec', '6'],
    ['rake generative', '30000'],
    ['bin/generative', '30000']
  ].each do |command, example_count|
    result = system %{#{command} | grep "#{example_count} examples, 0 failures"}

    unless result
      fail "`#{command}` had an incorrect example count"
    end
  end

  puts "Yay!"
end
