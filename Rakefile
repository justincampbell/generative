require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'generative/rake_task'

task default: [:spec, :generative, :acceptance]
task ci: [:spec, :generative]

RSpec::Core::RakeTask.new
Generative::RakeTask.new

desc "Verify all spec commands behave properly"
task :acceptance do
  ENV.delete('GENERATIVE_COUNT')

  [
    ['rspec', '16'], # can we do this some other way
    ['rake spec', '16'], # sucks to bump as we add tests...
    ['rake generative', '30000'],
    ['bin/generative', '30000']
  ].each do |command, expected_example_count|
    puts "Checking output of `#{command}`"
    output = %x{#{command}}
    pattern = /(\d+) examples, (\d+) failures/
    _, example_count, failure_count = output.match(pattern).to_a

    unless failure_count == '0'
      fail "`#{command}` had #{failure_count} failures"
    end

    unless example_count == expected_example_count
      fail "`#{command}` had an incorrect example count, " \
        "expected #{expected_example_count}, " \
        "but got #{example_count}"
    end
  end

  puts "Yay!"
end
