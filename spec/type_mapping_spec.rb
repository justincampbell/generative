require 'spec_helper'

describe TypeMapping do

  describe ".generator_for" do
    it "lets you create a new generator"
    it "can take class names or symbols as the argument to accessor"
    it "yields a generator to a block"
    it "registers the generator to a mapping from class names to generation methods"
  end

end
