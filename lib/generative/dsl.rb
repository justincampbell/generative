class RSpec::Core::ExampleGroup

  define_example_group_method :generative, { generative: true, order: :generative}

  class << self
    alias_method :data, :let
    alias_method :for_every, :let
  end

  def generate(generator_name, *args)
    Generative.generate(generator_name, *args)
  end
end
