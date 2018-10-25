# Rspec Json Helpers

[![Build Status](https://travis-ci.org/theincognitocoder/rspec-json_helpers.svg?branch=master)](https://travis-ci.org/theincognitocoder/rspec-json_helpers)
[![Coverage Status](https://coveralls.io/repos/github/theincognitocoder/rspec-json_helpers/badge.svg?branch=master)](https://coveralls.io/github/theincognitocoder/rspec-json_helpers?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/f9ac56f41cd6333d98ee/maintainability)](https://codeclimate.com/github/theincognitocoder/rspec-json_helpers/maintainability)

Rspec Json Helpers

## Links of Interest

* [Documentation](https://www.rubydoc.info/github/theincognitocoder/rspec-json_helpers/master)
* [Changelog](https://github.com/theincognitocoder/rspec-json_helpers/blob/master/CHANGELOG.md)

## Installation

Add rspec-json_helpers to your project's Gemfile and then bundle install.

    gem 'rspec-json_helpers', '0.9'

## Basic Usage

Add the following statement to your `spec_helper.rb`

    require 'rspec'
    require 'rspec/json_helpers'

You can now use the `equal_json` matcher in your RSpec tests. The `equal_json`
matcher compares the expected and actual strings as JSON values. The two
values must be equal.

* Whitespace is not significant
* JSON object attribute ordering is not signficant
* Array value ordering is significant
* null values are significant

### Example: insignificant whitespace

    it 'builds a JSON document' do
      expect('{"foo":"bar"}').to equal_json(<<~JSON)
        {
          "foo" : "bar"
        }
      JSON
    end

### Example: insignificant attribute ordering

    it 'builds a JSON document' do
      expect('{"key-1":"value-1","key-2":"value-2"}').to equal_json(<<~JSON)
        {
          "key-2": "key-2"
          "key-1": "value-1"
        }
      JSON
    end

### Example: Significant array ordering

    it 'builds a JSON document' do
      expect('[1,2,3]').to equal_json('[3,2,1]') # does not match
    end

result:

    expected: [
      1,
      2,
      3
    ]

    got: [
      3,
      2,
      1
    ]

    Diff:  [
    -  1,
    +  3,
       2,
    -  3
    +  1
     ]

### Example: Significant null values

    it 'builds a JSON document' do
      expect('{"key":null}').to equal_json('{}')
    end

result:

    expected: {
      "key": null
    }

    got: {
    }

    Diff:  {
    -  "key": null
     }

## License

MIT License

Copyright 2018 The Incognito Coder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
