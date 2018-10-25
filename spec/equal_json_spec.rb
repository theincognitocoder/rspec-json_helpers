# frozen_string_literal: true

module RSpec
  module JsonHelpers
    describe EqualJsonMatcher do

      it 'returns true when JSON values are equal' do
        matcher = EqualJsonMatcher.new('{}')
        expect(matcher.matches?('{}')).to be(true)
      end

      it 'returns false when JSON values are not equal' do
        matcher = EqualJsonMatcher.new('{}')
        expect(matcher.matches?('[]')).to be(false)
      end

      it 'it compares JSON documents indifferently of whitespace' do
        expected = '{"foo":"bar"}'
        actual = <<~JSON
          {
            "foo" : "bar"
          }
        JSON
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'it compares JSON documents indifferently of attribute order' do
        expected = '{"abc":"abc-value", "xyz": "xyz-value"}'
        actual = '{"xyz":"xyz-value", "abc": "abc-value"}'
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'expects actual values to not have extra attributes' do
        expected = '{"abc": "abc-value"}'
        actual = '{"abc":"abc-value", "xyz": "xyz-value"}'
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(false)
      end

      it 'expects actual values to not have fewer attributes' do
        expected = '{"abc":"abc-value", "xyz": "xyz-value"}'
        actual = '{"abc": "abc-value"}'
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(false)
      end

      it 'compares JSON arrays' do
        expected = '{ "items": [1,2,3] }'
        actual = '{ "items": [1,2,3] }'
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'expects array values to have the same order' do
        expected = '[1,2,3]'
        actual = '[3,2,1]'
        matcher = EqualJsonMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(false)
      end

      it 'provides a helpful diff when the JSON values do not match' do
        expected = '{ "items": [1,2,3] }'
        actual = '{ "items": [3,2,1] }'
        matcher = EqualJsonMatcher.new(expected, colorize: false)
        matcher.matches?(actual) # false
        expect(matcher.failure_message).to eq(<<~MESSAGE)
          expected: {
            "items": [
              1,
              2,
              3
            ]
          }

          got: {
            "items": [
              3,
              2,
              1
            ]
          }

          Diff:  {
             "items": [
          -    1,
          +    3,
               2,
          -    3
          +    1
             ]
           }
        MESSAGE
      end

      it 'provides a helpful failure message when actual is the wrong type' do
        matcher = EqualJsonMatcher.new('{}')
        matcher.matches?(nil)
        expect(matcher.failure_message).to eq('Expected a JSON string, got NilClass.')
      end

      it 'raises an error when the expected value is not a string' do
        expect do
          EqualJsonMatcher.new(123)
        end.to raise_error(ArgumentError, 'Expected a JSON string, got Fixnum.')
      end

      it 'raises an error when the expected value is not valid JSON' do
        expect do
          EqualJsonMatcher.new('---')
        end.to raise_error(ArgumentError, /Expected a string containing valid JSON/)
      end

    end
  end
end
