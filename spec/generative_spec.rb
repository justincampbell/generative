require 'generative'
require 'random_data'

describe String do
  let(:string) { "abc" }

  describe "#length" do
    it "counts characters" do
      expect(string.length).to eq(3)
    end

    xit "does other stuff"

    generative do
      data(:string) { [Random.alphanumeric, Random.paragraphs].sample }

      it "is never negative", :generative do
        expect(string.length).to be >= 0
      end
    end
  end

  describe "#reverse" do
    it "reverses" do
      expect(string.reverse).to eq("cba")
    end

    generative do
      data(:string) { [Random.alphanumeric, Random.paragraphs].sample }

      it "maintains length" do
        expect(string.reverse.length).to eq(string.length)
      end

      it "is not destructive" do
        expect(string.reverse.reverse).to eq(string)
      end
    end
  end
end
