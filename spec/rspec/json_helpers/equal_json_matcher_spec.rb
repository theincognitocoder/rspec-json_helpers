# frozen_string_literal: true

module RSpec
  module JsonHelpers

    describe EqualJsonMatcher do
      it 'returns true when JSON values are equal' do
        expect('{}').to equal_json('{}')
      end

      it 'returns false when JSON values are not equal' do
        expect('{}').not_to equal_json('[]')
      end

      it 'it compares JSON documents indifferently of whitespace' do
        expected = '{"foo":"bar"}'
        actual = <<~JSON
          {
            "foo" : "bar"
          }
        JSON
        expect(actual).to equal_json(expected)
      end

      it 'it compares JSON documents indifferently of attribute order' do
        expected = '{"abc":"abc-value", "xyz": "xyz-value"}'
        actual = '{"xyz":"xyz-value", "abc": "abc-value"}'
        expect(actual).to equal_json(expected)
      end

      it 'expects actual values to not have extra attributes' do
        expected = '{"abc": "abc-value"}'
        actual = '{"abc":"abc-value", "xyz": "xyz-value"}'
        expect(actual).not_to equal_json(expected)
      end

      it 'expects actual values to not have fewer attributes' do
        expected = '{"abc":"abc-value", "xyz": "xyz-value"}'
        actual = '{"abc": "abc-value"}'
        expect(actual).not_to equal_json(expected)
      end

      it 'compares JSON arrays' do
        expected = '{ "items": [1,2,3] }'
        actual = '{ "items": [1,2,3] }'
        expect(actual).to equal_json(expected)
      end

      it 'expects array values to have the same order' do
        expected = '[1,2,3]'
        actual = '[3,2,1]'
        expect(actual).not_to equal_json(expected)
      end

      it 'provides a helpful diff when the JSON values do not match' do
        expected = '{ "items": [1,2,3] }'
        actual = '{ "items": [3,2,1] }'
        # using matcher class to disable colorization
        matcher = EqualJsonMatcher.new(expected, colorize: false)
        expect(matcher.matches?(actual)).to be(false)
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
        expect do
          expect(nil).to equal_json('{}')
        end.to raise_error('Expected a JSON string, got NilClass.')
      end

      it 'raises an error when the expected value is not a string' do
        expect do
          expect('{}').to equal_json(nil)
        end.to raise_error('Expected a JSON string, got NilClass.')
      end

      it 'raises an error when the expected value is not valid JSON' do
        expect do
          expect('---').to equal_json('{}')
        end.to raise_error(/Expected a string containing valid JSON/)
      end

      it 'implements a negation error message' do
        expect do
          expect('{}').not_to equal_json('{}')
        end.to raise_error('expected JSON value not to be equal')
      end
    end

  end
end
