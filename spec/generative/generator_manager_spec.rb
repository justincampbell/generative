require 'spec_helper'

describe Generative::GeneratorManager do

  subject { Generative::GeneratorManager.new }

  describe "#register_generator_generator" do
    it "throws an exception if a block or a factory object isn't given" do
      expect { subject.register_generator(:test) }.to raise_error(Generative::InvalidGenerator)
    end

    it "registers a new generator when given a generator block" do
      name, generator = :test, lambda { "hi" }
      expect(subject.generators).not_to include(name)
      expect(subject.register_generator(name) { "hi" }).to include(name)
      expect(subject.generators[name].call).to eq("hi")
    end

    it "registers a new generator when given a factory object" do
      name, factory = :test, OpenStruct.new(call: true)
      expect(subject.generators).not_to include(name)
      expect(subject.register_generator(name, factory)).to include(name)
      expect(subject.generators[name].call).to be_truthy
    end
  end

  describe "#find_and_call" do
    it "calls a specific generator passing in it's arguments" do
      name, generator = :test, lambda { |arg| arg }
      subject.register_generator(name, &generator)
      expect(subject.find_and_call(name, "hi")).to eq("hi")
    end

    it "raises an error fo ran unregistered generator" do
      expect { subject.find_and_call(:nope) }
        .to raise_error(Generative::UnregisteredGenerator)
    end

    describe "#generator_valid?" do
      it "returns false if an object doesn't respond to :call or :build" do
        expect(subject.generator_valid?(nil)).to be_falsey
      end

      it "returns true if an object doesn't respond to :call" do
        generator = OpenStruct.new(call: true)
        expect(subject.generator_valid?(generator)).to be_truthy
      end
    end
  end
end
