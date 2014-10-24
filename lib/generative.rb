require 'rspec/core'

module Generative
  DEFAULT_COUNT = '10_000'

  def self.manager
    @manager ||= GeneratorManager.new(preregistered_generators)
  end

  def self.preregistered_generators
    {
        # nothing to see here yet
    }
  end

  def self.running?
    !!ENV['GENERATIVE_COUNT']
  end
end

require 'generative/dsl'
require 'generative/formatters'
require 'generative/ordering'
require 'generative/generator_manager'
