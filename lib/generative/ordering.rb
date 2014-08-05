Generative::ORDERING = ->(examples) {
  generative, regular = examples.partition { |example|
    example.metadata[:generative]
  }

  number_of_examples = ENV.fetch('GENERATIVE_COUNT', '1').to_i

  regular + generative * number_of_examples
}

RSpec.configure do |rspec|
  rspec.register_ordering(:generative, &Generative::ORDERING)
end
