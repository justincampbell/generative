require 'rspec/core/formatters/progress_formatter'

class RSpec::Core::Formatters::ProgressFormatter
  def example_passed(example)
    super(example)

    if example.metadata[:generative]
      output.print detail_color('.')
    else
      output.print success_color('.')
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
