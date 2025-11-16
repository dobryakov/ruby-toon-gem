module Toon
  class Error < StandardError; end

  class EncodingError < Error; end
  class DecodingError < Error; end

  class UnsupportedTypeError < EncodingError; end
  class SpecialFloatError < EncodingError; end

  class DuplicateKeyError < DecodingError; end
  class MalformedInputError < DecodingError; end
end


