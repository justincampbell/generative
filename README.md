# Generative

> Generative testing for RSpec
> [![Gem Version](https://badge.fury.io/rb/generative.png)](http://badge.fury.io/rb/generative)
> [![Build Status](https://travis-ci.org/justincampbell/generative.png?branch=master)](https://travis-ci.org/justincampbell/generative)
> [![Code Climate](https://codeclimate.com/github/justincampbell/generative.png)](https://codeclimate.com/github/justincampbell/generative)

## Installation

You're already using RSpec 3, right? Of course you are.

### Add Generative to your Gemfile:

```rb
group :test do
  gem 'generative'
  gem 'rspec', '3.0.0.beta1'
end
```

### Require Generative in your `.rspec` file:

```
--color
--format progress
--require generative
```

### Modify your `Rakefile` to create separate `spec` and `generative` tasks:

```rb
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

ENV['GENERATIVE_COUNT'] = '10_000'

task default: [:spec, :generative]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--format documentation --tag ~generative'
end

RSpec::Core::RakeTask.new(:generative) do |t|
  t.rspec_opts = '--format Generative --tag generative'
end
```

## Usage

### Specs

In your tests, add a `generative` block. This is a essentially the same as a
`context` or `describe` block. Inside the block, define some `data` as you
would a `let`. Then, write your `it`/`specify` blocks as usual (while keeping
in mind that the input could be anything).

```rb
describe String do
  let(:string) { "abc" }

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
```

Now, run your tests with `rake` or `rspec`.

### Number of Tests

Generative uses the `GENERATIVE_COUNT` environment variable to control how many
tests to run for each example. It defaults to 100, and in the example
`Rakefile` above, we set it to 10,000.

### Formatters

Given the examples above, running `rspec` will use the default "progress"
formatter. Requiring generative will modify this formatter to output blue dots
instead of green for generative tests. Generative also includes it's own
formatter, which will only display generative test names once, also in blue.
