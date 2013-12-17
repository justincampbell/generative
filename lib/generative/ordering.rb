Generative::ORDERING = ->(examples) {
  number_of_examples = ENV.fetch('GENERATIVE_COUNT', '1').to_i
  examples * number_of_examples
}

RSpec.configure do |rspec|
  case RSpec::Core::Version::STRING
  when /^2/
    rspec.order_examples(&Generative::ORDERING) if ENV['GENERATIVE_COUNT']
  when /^3/
    rspec.register_ordering(:generative, &Generative::ORDERING)
  else
    puts "Generative was unable to determine the RSpec version."
  end
end
