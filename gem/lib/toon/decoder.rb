require "json"

module Toon
  DecodeResult = Struct.new(:value, :diagnostics, :errors, keyword_init: true)

  class Decoder
    def initialize(options = nil)
      @options = CodecOptions.from(options)
    end

    def decode(input)
      value = parse(input)
      validate_decoded!(value)
      value
    rescue DecodingError => e
      raise e
    rescue StandardError => e
      raise MalformedInputError, e.message
    end

    def decode_safe(input)
      diagnostics = []
      errors = []
      value = nil

      begin
        value = decode(input)
      rescue DecodingError => e
        errors << e.message
        value = nil
      end

      DecodeResult.new(value: value, diagnostics: diagnostics, errors: errors)
    end

    private

    def parse(input)
      str = case input
            when String
              input.dup
            else
              raise MalformedInputError, "Input must be a String"
            end

      JSON.parse(str)
    rescue JSON::ParserError => e
      raise MalformedInputError, e.message
    end

    def validate_decoded!(value)
      case value
      when nil, true, false, String, Integer
        true
      when Float
        if @options.reject_special_floats && !value.finite?
          raise SpecialFloatError, "NaN and Infinity not allowed when reject_special_floats is true"
        end
      when Array
        value.each { |v| validate_decoded!(v) }
      when Hash
        # Ruby's JSON parser already applies last-wins semantics for duplicate keys.
        # Here we only validate key/value types.
        value.each do |k, v|
          unless k.is_a?(String)
            raise MalformedInputError, "Decoded hash keys must be strings, got #{k.class}"
          end
          validate_decoded!(v)
        end
      else
        raise MalformedInputError, "Unsupported decoded type: #{value.class}"
      end
    end
  end
end


