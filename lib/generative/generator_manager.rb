module Generative
  class InvalidGenerator < StandardError; end
  class UnregisteredGenerator < StandardError; end

  class GeneratorManager

    attr_reader :generators

    def initialize(preregistered_generators={})
      @generators = Hash.new(preregistered_generators)
    end

    def register(name, generator)
      msg = "#{generator} must respond to :call"
      raise InvalidGenerator, msg unless generator_valid?(generator)
      @generators.merge!(name => generator)
    end

    def find_and_call(name, *args)
      begin
        generators[name].call(*args)
      rescue NoMethodError
        raise UnregisteredGenerator, "#{name} generator not registered"
      end
    end

    def generator_valid?(generator)
      generator.respond_to?(:call)
    end
  end
end
