# frozen_string_literal: true

require 'diff-lcs'
require 'diffy'
require 'stringio'

module RSpec
  module JsonHelpers
    # @api private
    class EqualJsonMatcher

      def initialize(expected, colorize: true)
        @expected = JsonHelpers.normalize_json(expected)
        @diff_format = colorize ? :color : :text
      end

      def matches?(actual)
        @actual = JsonHelpers.normalize_json(actual)
        @expected == @actual
      rescue ArgumentError => error
        @wrong_type_error_message = error.message
        false
      end

      def failure_message
        @wrong_type_error_message || diff_json_error_message
      end

      def failure_message_when_negated
        'expected JSON value not to be equal'
      end

      def diff_json_error_message
        message = StringIO.new
        message << "expected: #{@expected}\n\n"
        message << "got: #{@actual}\n\n"
        message << "Diff: #{diff}"
        message.string
      end

      def diff
        diff = Diffy::Diff.new(@expected, @actual).to_s(@diff_format)
        diff.lines[0..-2].join
      end

    end
  end
end
