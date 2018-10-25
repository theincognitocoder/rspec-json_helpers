# frozen_string_literal: true

require 'json'

module RSpec
  module JsonHelpers
    # @api private
    class Formatter

      WRONG_TYPE = 'Expected a JSON string, got %<type>s.'

      # @param [String<JSON>] json
      # @return [String<JSON>]
      # @raise ArgumentError Raises `ArgumentError` when the given
      #   json value is not a string, or when when there is an error
      #   parsring string as JSON.
      def format(json)
        dump_json(deep_sort(load_json(json)))
      rescue JSON::ParserError => e
        raise ArgumentError, 'Expected a string containing valid ' \
          "JSON; got #{e.class.name}: #{e.message}"
      end

      private

      def load_json(json)
        if json.is_a?(String)
          JSON.load(json)
        else
          raise ArgumentError, Kernel.format(WRONG_TYPE, type: json.class.name)
        end
      end

      def dump_json(value)
        JSON.pretty_generate(value, indent: '  ')
      end

      def deep_sort(obj)
        case obj
        when Hash
          obj.keys.sort.each_with_object({}) do |key, hash|
            hash[key] = deep_sort(obj[key])
          end
        when Array
          obj.map { |value| deep_sort(value) }
        when String, Numeric, true, false, nil
          obj
        end
      end

    end
  end
end
