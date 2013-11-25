require 'spec_helper'

describe Generator do

  let(:class_instance) { Class.new { attr_accessor :bar, :baz  } }
  let(:generator) { Generator.new(class_instance, { bar: :string, baz: :fixnum }) }

  describe "#model_class" do
    it "knows what class it can build" do
      expect(generator.model_class).to eq(class_instance)
    end
  end

  describe "#build" do
    it "can build a random instance of it's class" do
      model = generator.build
      expect(model.bar.class).to eq(String)
      expect(model.baz.class).to eq(Fixnum)
    end
  end
end
