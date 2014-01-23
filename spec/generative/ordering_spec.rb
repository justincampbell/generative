require 'spec_helper'

describe Generative::ORDERING do
  let(:ordering) { Generative::ORDERING }

  around do |example|
    previous = ENV['GENERATIVE_COUNT']
    ENV['GENERATIVE_COUNT'] = '10'

    example.call

    ENV['GENERATIVE_COUNT'] = previous
  end

  it "does not duplicate regular specs" do
    spec = double metadata: {}
    expect(ordering.call([spec])).to eq([spec])
  end

  it "duplicates generative specs" do
    spec = double metadata: { generative: true }
    expect(ordering.call([spec])).to have(10).items
  end
end
