# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'coveralls'
require 'simplecov'
require 'rspec'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
])
SimpleCov.start

require 'rspec/json_helpers'
