require_relative "toon/version"
require_relative "toon/errors"
require_relative "toon/codec_options"
require_relative "toon/encoder"
require_relative "toon/decoder"

module Toon
  def self.encode(value, options = nil)
    Encoder.new(options).encode(value)
  end

  def self.decode(input, options = nil)
    Decoder.new(options).decode(input)
  end

  def self.decode_safe(input, options = nil)
    Decoder.new(options).decode_safe(input)
  end
end


