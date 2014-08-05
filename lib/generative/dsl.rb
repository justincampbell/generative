class RSpec::Core::ExampleGroup

  define_example_group_method :generative, { generative: true, order: :generative}

  class << self
    alias_method :data, :let
  end
end
