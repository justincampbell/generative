require 'rspec/core/formatters/progress_formatter'
require 'rspec/core/formatters/console_codes'

class RSpec::Core::Formatters::ProgressFormatter

  alias super_example_passed example_passed

  def example_passed(example)
    if example.example.metadata[:generative]
      output.print RSpec::Core::Formatters::ConsoleCodes.wrap('.', :detail)
    else
      super_example_passed(example)
    end
  end
end

require 'rspec/core/formatters/documentation_formatter'

module Generative
  class Formatter < RSpec::Core::Formatters::DocumentationFormatter
    def initialize(output)
      super(output)
    end

    def example_group_started(example_group)
      @example_group = example_group

      output.puts if @group_level == 0

      if generative?(example_group)
        output.puts "#{current_indentation}#{detail_color('generative')}"

        @group_level += 1
        example_group.examples.each do |example|
          output.puts "#{current_indentation}#{detail_color(example.description)}"
        end

        @group_level -= 1
      else
        output.puts "#{current_indentation}#{example_group.description.strip}"
      end

      @group_level += 1
    end

    def example_passed(example)
      return if generative?(example)

      super(example)
    end

    def example_pending(example)
      return if generative?(example)

      super(example)
    end

    def example_failed(example)
      if generative?(example)
        RSpec.wants_to_quit = true
      end

      super(example)
    end

    private

    def generative?(example)
      example.metadata[:generative]
    end
  end
end
