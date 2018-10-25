# frozen_string_literal: true

require_relative 'json_helpers/equal_json_matcher'
require_relative 'json_helpers/formatter'

module RSpec
  # Provides a `equal_json` rspec matcher.
  module JsonHelpers

    # @param [String<JSON>] expected
    # @raise ArgumentError Raises an ArgumentError when the expected
    #   value is not a String that contains valid JSON.
    def equal_json(expected)
      EqualJsonMatcher.new(expected)
    end

    class << self

      # @param [String<JSON>] json
      # @return [String<JSON>]
      # @raise ArgumentError Raises an ArgumentError when the given
      #   value is not valid JSON. expected
      # @api private
      def normalize_json(json)
        Formatter.new.format(json)
      end

    end

  end
end

RSpec.configure do |config|
  config.include RSpec::JsonHelpers
end

RSpec::Matchers.alias_matcher :eq_json, :equal_json
