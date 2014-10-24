require 'spec_helper'

describe Generative::GeneratorManager do

  subject { Generative::GeneratorManager.new }

  describe "#register" do
    it "throws an exception if the generator doesn't respond to :call" do
      expect { subject.register(:test, nil) }.to raise_error(Generative::InvalidGenerator)
    end

    it "registers a new generator" do
      name, generator = :test, lambda { "hi" }
      expect(subject.generators).not_to include(name)
      expect(subject.register(name, generator)).to include(name)
      expect(subject.generators[name].call).to eq("hi")
    end
  end

  describe "#find_and_call" do
    it "calls a specific generator passing in it's arguments" do
      name, generator = :test, lambda { |arg| arg }
      subject.register(name, generator)
      expect(subject.find_and_call(name, "hi")).to eq("hi")
    end

    it "raises an error fo ran unregistered generator" do
      expect { subject.find_and_call(:nope) }
        .to raise_error(Generative::UnregisteredGenerator)
    end
  end
end
