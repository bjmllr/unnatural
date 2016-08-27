# Unnatural

[![Gem Version](https://badge.fury.io/rb/unnatural.svg)](https://rubygems.org/gems/unnatural)
[![Build Status](https://travis-ci.org/bjmllr/unnatural.svg)](https://travis-ci.org/bjmllr/unnatural)

A natural sort for Ruby.

Unnatural defines a natural sort as one where:

1. comparison is case-insensitive
2. consecutive sequences of digits are compared according to their numeric value (not their ascii values)

Unnatural does not (currently) provide support for:

1. non-ASCII-compatible encoding (although the pure ruby comparison functions seem to work)
2. any number representation other than simple decimal integers
3. whitespace insensitivity (i.e., one space and two spaces can be considered as different)

Unnatural provides four algorithms, all of which use Ruby's built-in quicksort as the fundamental sort algorithm. All four modules provide module methods `.sort` for simply sorting an enumerable, `.sort_by` for a memoized sort according to a block, and `.compare` for spaceship-operator-style comparison.

### Unnatural::Fast

Compares strings byte-by-byte. Comparison function implemented in C. Does not appear to sort unicode strings correctly. Much faster than any of the pure Ruby options. The default.

### Unnatural::Scan

Compares strings using a `StringScanner`. Pure ruby. Tends to be outperformed by `Unnatural::Substitution` and `Unnatural::Split` when sorting short strings via the global sort function, but its comparison function is the fastest of the pure-ruby algorithms.

### Unnatural::Split

Compares strings by spliting them into arrays of alternating string and integer values. Pure Ruby. Tends to be outperformed by the others.

### Unnatural::Substitution

Compares strings by zero-padding integer sequences such that all are the same length. Pure Ruby. Tends to be outperformed by `Unnatural::Scan` on longer strings. Recommended for sorting short unicode strings.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unnatural'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unnatural

## Usage

Sorting an enumerable of strings:

```ruby
require 'unnatural'
sorted = Unnatural.sort(some_array_of_strings)
```

Sorting an enumerable of objects according to a block:

```ruby
sorted = Unnatural.sort_by(some_array_of_objects) { |e| e.name }
sorted = Unnatural.sort_by(some_array_of_objects, &:name)
```

Defining the comparison method for a class explicitly:

```ruby
require 'unnatural'

class User
  def <=>(other)
    Unnatural.compare(name, other.name)
  end
end
```

Or by defining `#to_str` and using Unnatural as a mix-in:

```ruby
# this is equivalent to the last example

class User
  include Unnatural

  def to_str
    name
  end
end
```

The default can be changed throughout an application:

```ruby
# use Scan instead of Fast
Unnatural.algorithm = Unnatural::Scan
```

Or you can use the `.compare` and `.sort` functions for an algorithm's module directly:

```ruby
sorted_short_strings = Unnatural::Substitution.sort(some_short_strings)
sorted_long_strings = Unnatural::Scan.sort(some_long_strings)

class User
  def <=>(other)
    Unnatural::Scan.compare(name, other.name)
  end
end
```

## See Also

There are two other natural sort gems:

https://github.com/dogweather/naturally

https://github.com/johnnyshields/naturalsort

Unnatural took test cases from each one.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bjmllr/unnatural. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

