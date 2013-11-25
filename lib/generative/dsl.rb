class RSpec::Core::ExampleGroup
  def self.generative(name = nil, &block)
    name = "(#{name})" if name
    name = "\033[36mgenerative#{name}\033[0m"

    describe(name, generative: true, order: :generative, &block)
  end

  def generate(type)
    RandomTypes.data(type)
  end

  class << self
    alias_method :data, :let
  end
end
