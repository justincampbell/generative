class RSpec::Core::ExampleGroup

  define_example_group_method :generative, { generative: true, order: :generative}

  class << self
    alias_method :data, :let
  end

  def generate(generator_name, *args)
    # somehow get the instance of GeneratorManager and delegate to it's
    # #find_and_call method...
  end
end
