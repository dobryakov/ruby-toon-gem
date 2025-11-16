module Toon
  class CodecOptions
    attr_reader :binary_output,
                :reject_special_floats,
                :duplicate_key_policy,
                :canonical_encode

    def initialize(
      binary_output: false,
      reject_special_floats: false,
      duplicate_key_policy: :raise,
      canonical_encode: true
    )
      @binary_output = binary_output
      @reject_special_floats = reject_special_floats
      @duplicate_key_policy = duplicate_key_policy
      @canonical_encode = canonical_encode
    end

    def self.from(options)
      case options
      when nil
        new
      when CodecOptions
        options
      when Hash
        new(**options.transform_keys(&:to_sym))
      else
        raise ArgumentError, "Unsupported options type: #{options.class}"
      end
    end
  end
end


