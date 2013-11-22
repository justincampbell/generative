require 'randexp'

module Inferencer

  def self.instance_of(model_class)
    instance = model_class.new
    model_class.column_types.each do |name, info|
      instance[name] = LameRandom.data(info.type)
    end

    return instance
  end
end

module LameRandom

  def self.data(type)
    send type
  end

  def self.float
    rand * 10 ** rand(10)
  end

  def self.boolean
    rand(2) == 0
  end

  def self.integer
    rand(4294967295)
  end

  def self.string
    5.times.map { /(\w+)/.gen }.join(" ")
  end

  def self.hstore
    {}
  end

  def self.datetime
    Time.now + (rand(2) % 2 == 0 ? 1 : -1  ) * rand(300000000)
  end

  def self.date
    Date.parse(datetime.to_s)
  end

  class << self
    alias_method :decimal, :float
  end

end
