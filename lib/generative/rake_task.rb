require 'generative'
require 'rspec/core/rake_task'

module Generative
  class RakeTask < RSpec::Core::RakeTask
    def initialize(*args, &task_block)
      super

      self.name = :generative if name == :spec

      desc "Run Generative specs" unless Rake.application.last_comment

      options = %w[
        --require generative
        --format Generative::Formatter
        --tag generative
      ]

      self.rspec_opts = options.join(' ')

      task name, *args do |_, task_args|
        RakeFileUtils.send(:verbose, verbose) do
          ENV['GENERATIVE_COUNT'] ||= Generative::DEFAULT_COUNT
          task_block.call(*[self, task_args].slice(0, task_block.arity)) if task_block
          run_task verbose
        end
      end
    end
  end
end
