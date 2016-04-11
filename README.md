Hky
===========================

[![Build Status](https://travis-ci.org/BakaBBQ/hky.svg?branch=master)](https://travis-ci.org/BakaBBQ/hky)

Hky (Hooky) is a 25-loc library with 3 methods extracted to help monkey-patching.

## Synopsis

```ruby
require 'hky'

# Only 3 methods are exposed

class Something
  # Something has been already defined
  # We are monkeypatching it
  extend Hky

  def_before :foo do
    this_will_be_executed_before_foo_is_called
  end

  def_after :foo do
    this_will_be_executed_after_foo_is_called
  end

  def_around :foo do |ori_value|
    ori_value.concat [1,2,3]
  end
end
```
## Installation



## Intro

I am sure this is probably implemented many times. Yet during a long day where I have no internet access and I need this. I decided to roll my own.

It is fairly simple and should work, and it is a nice way to work around
aliasing everywhere.

## License

Unlicense
