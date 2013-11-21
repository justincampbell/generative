RSpec.configure do |rspec|
  rspec.register_ordering :generative do |examples|
    number_of_examples = ENV.fetch('GENERATIVE_COUNT', '100').to_i

    examples * number_of_examples
  end
end
