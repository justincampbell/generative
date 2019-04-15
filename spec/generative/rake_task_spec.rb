require 'spec_helper'
require 'generative/rake_task'

RSpec.describe Generative::RakeTask do
  let(:task) { Generative::RakeTask.new(*args) }
  let(:args) { [] }

  describe "name" do
    subject(:name) { task.name }

    it "has a default" do
      expect(name).to eq(:generative)
    end

    context "when passed a name" do
      let(:args) { [:properties] }

      it "uses that name" do
        expect(name).to eq(:properties)
      end
    end
  end

  describe "rspec_opts" do
    subject(:rspec_opts) { task.rspec_opts }

    it "require generative" do
      expect(rspec_opts).to include("--require generative")
    end

    it "format with Generative::Formatter" do
      expect(rspec_opts).to include("--format Generative::Formatter")
    end

    it "only run specs tagged with generative" do
      expect(rspec_opts).to include("--format Generative::Formatter")
    end
  end
end
