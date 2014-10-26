require 'generative'

Generative.manager.register_generator(:string) { "a" * rand(255) }

describe String do
  let(:string) { "abc" }

  describe "#length" do
    it "counts characters" do
      expect(string.length).to eq(3)
    end

    xit "still prints pending spec names"

    generative do
      data(:string) { "a" * rand(255) }

      it "is never negative" do
        expect(string.length).to be >= 0
      end
    end

    xit "uses registered generators"

    generative do
      data(:string) { generate(:string) }

      it "is never negative" do
        expect(string.length).to be >= 0
      end
    end
  end

  describe "#reverse" do
    it "reverses" do
      expect(string.reverse).to eq("cba")
    end

    generative do
      data(:string) { rand(12345).to_s }

      it "maintains length" do
        expect(string.reverse.length).to eq(string.length)
      end

      it "is not destructive" do
        expect(string.reverse.reverse).to eq(string)
      end
    end
  end
end
