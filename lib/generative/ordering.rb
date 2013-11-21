RSpec.configure do |rspec|
  rspec.register_ordering :generative do |examples|
    time_per_example = ENV.fetch('GENERATIVE_FACTOR', '0.001').to_f
    end_time = Time.now.to_f + (examples.count * time_per_example)

    Enumerator.new { |enumerator|
      while Time.now.to_f < end_time && !RSpec.wants_to_quit
        enumerator.yield(examples.sample)
      end
    }
  end
end
