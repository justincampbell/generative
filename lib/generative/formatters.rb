require 'rspec/core/formatters/progress_formatter'
require 'rspec/core/formatters/console_codes'

class RSpec::Core::Formatters::ProgressFormatter
  alias_method :super_example_passed, :example_passed

  def example_passed(notification)
    example = notification.example

    if example.metadata[:generative]
      output.print RSpec::Core::Formatters::ConsoleCodes.wrap('.', :cyan)
    else
      super_example_passed(notification)
    end
  end
end

require 'rspec/core/formatters/documentation_formatter'

module Generative
  class Formatter < RSpec::Core::Formatters::DocumentationFormatter
    RSpec::Core::Formatters.register self,
      :example_failed,
      :example_group_started,
      :example_passed,
      :example_pending

    def initialize(output)
      super
    end

    def example_group_started(notification)
      example_group = notification.group

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

    def example_passed(notification)
      example = notification.example

      return if generative?(example)

      super
    end

    def example_pending(notification)
      example = notification.example

      return if generative?(example)

      super
    end

    def example_failed(notification)
      example = notification.example

      if generative?(example)
        RSpec.wants_to_quit = true
      end

      super
    end

    private

    def detail_color(text)
      RSpec::Core::Formatters::ConsoleCodes.wrap(text, :cyan)
    end

    def generative?(example)
      example.metadata[:generative]
    end
  end
end
