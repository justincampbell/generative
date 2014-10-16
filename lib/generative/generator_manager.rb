module Generative
  class InvalidGenerator < StandardError; end

  class GeneratorManager

    attr_reader :generators

    def initialize
      @generators = Hash.new(default_generators)
    end

    def register(name, generator)
      msg = "#{generator} must respond to :call"
      raise InvalidGenerator, msg unless generator_valid?(generator)
      @generators.merge!(name => generator)
    end

    def find_and_call(name, *args)
      generators[name].call(*args)
    end

    def generator_valid?(generator)
      generator.respond_to?(:call)
    end

    def default_generators
      {
        #nothing to see here yet
      }
    end
  end
end
