require "json"

module Toon
  class Encoder
    def initialize(options = nil)
      @options = CodecOptions.from(options)
    end

    def encode(value)
      normalized = normalize(value)
      json = JSON.generate(normalized)
      if @options.binary_output
        json.force_encoding(Encoding::ASCII_8BIT)
      else
        json.force_encoding(Encoding::UTF_8)
      end
    end

    private

    def normalize(value)
      case value
      when nil, true, false, String, Integer
        value
      when Float
        raise SpecialFloatError, "NaN and Infinity are not allowed in encode" unless value.finite?
        value
      when Array
        value.map { |v| normalize(v) }
      when Hash
        # Canonicalize by key (string representation) if enabled
        pairs = value.to_a
        if @options.canonical_encode
          pairs = pairs.sort_by { |k, _| k.to_s }
        end
        pairs.each_with_object({}) do |(k, v), acc|
          key = k.is_a?(Symbol) ? k.to_s : k
          unless key.is_a?(String)
            raise UnsupportedTypeError, "Hash keys must be strings or symbols, got #{k.class}"
          end
          acc[key] = normalize(v)
        end
      else
        raise UnsupportedTypeError, "Unsupported type for encode: #{value.class}"
      end
    end
  end
end


