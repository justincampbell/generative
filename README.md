# Generative

> Generative and property-based testing for RSpec
> [![Gem Version](https://badge.fury.io/rb/generative.png)](http://badge.fury.io/rb/generative)
> [![Build Status](https://travis-ci.org/justincampbell/generative.png?branch=master)](https://travis-ci.org/justincampbell/generative)
> [![Code Climate](https://codeclimate.com/github/justincampbell/generative.png)](https://codeclimate.com/github/justincampbell/generative)

## Installation

### Add Generative to your Gemfile (or gemspec):

```rb
group :test do
  gem 'generative'
  gem 'rspec'
end
```

...and then run `bundle`.

### Require Generative in your `.rspec` file:

```
--color
--format Generative::Formatter
--require generative
```

### (Optional) Require the Generative Rake task in your `Rakefile`:

```rb
require 'rspec/core/rake_task'
require 'generative/rake_task'

task(:default).enhance [:spec, :generative]

RSpec::Core::RakeTask.new
Generative::RakeTask.new
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

Alternatively, you can modify existing specs in a minimally intrusive way by just adding two tags to an existing context and using the fact that `data` is just an alias for `let`:
```ruby
describe String do
  let(:string) { "abc" }

  describe "#reverse", generative: true, order: :generative do
    let(:string) { rand(12345).to_s }

    it "maintains length" do
      expect(string.reverse.length).to eq(string.length)
    end

    it "is not destructive" do
      expect(string.reverse.reverse).to eq(string)
    end
  end
end
```
### Running

Generative comes with a `generative` command, which simply runs rspec with the
required arguments:

```
$ generative
+ GENERATIVE_COUNT=10_000
+ rspec --require generative --format Generative::Formatter --tag generative
Run options: include {:generative=>true}

String
  #length
    generative
      is never negative
  #reverse
    generative
      maintains length
      is not destructive

Finished in 2.28 seconds
30000 examples, 0 failures
```

If you've added the Generative task to your `Rakefile`, you can also simply run
`rake ` to run all tests, including Generative ones.

### Number of Tests

Generative uses the `GENERATIVE_COUNT` environment variable to control how many
tests to run for each example. Both the `generative` command and the example
`Rakefile` above set it to 10,000.

### Formatters

Given the examples above, running `rspec` will use the default "progress"
formatter. Requiring generative will modify this formatter to output blue dots
instead of green for generative tests. Generative also includes it's own
formatter, which will only display generative test names once, also in blue.

### Generators

Generative allows you to register your own custom generators for generative
tests. Registering a generator requires two thing, a name and an object that
responds to `#call`.

Whether you just want to use lambdas.

```rb
Generative.register_generator(:full_name) { "#{Generative.generate(:string)} #{Generative.generate(:string}" }

Generative.register_generator(:user) { FactoryGirl.build(:user, id: Generative.generate(:integer)) }
```

A class or module that responds to `#call`.

```rb
class LameGenerator
  def self.call
    random_string
  end
end

Generative.register_generator(:lame, LameGenerator)
```

Or you want to use a fancy library.

```rb
FakeTypeMappingLibrary
  generator_for Bar do
    initializer Float, Fixnum

    accessor :baz, Float
    accessor :quz, NotherClass
  end
end

Generative.register_generator(:bar, Bar }
```

You can then use your generators using the `generate` helper.

```rb
describe String do
  let(:string) { "abc" }

  describe "#reverse" do
    generative do
      data(:string) { generate(:my_fancy_string) }

      it "maintains length" do
        expect(string.reverse.length).to eq(string.length)
      end
    end
  end
end
```

#### I heard you like generators so I put some generators in your generators...

If you want to use other generators in you registered generator do note
you have to use Generative's module level method `.generate` like so...

```rb
Generative.register_generator :user do
  User.new( first_name: Generative.generate(:string, max: 100) )
end
```



### Pre-made Generators

**Note**: At this time Generative provides no pre-made generators. We
encourage you to go out and seek good ways of generating
data and maybe even package them up as your own gems. If you
do, let us know and we'll link to it here.


#### [Degenerate](https://github.com/niftyn8/degenerate)

This library has a few generators for some basic primitives... A great start if
you're looking to move quickly.
