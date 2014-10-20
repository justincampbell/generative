require 'rspec/core'

module Generative
  DEFAULT_COUNT = '10_000'

  def self.running?
    !!ENV['GENERATIVE_COUNT']
  end
end

require 'generative/dsl'
require 'generative/formatters'
require 'generative/ordering'
require 'generative/generator_manager'
