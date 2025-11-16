require "logger"
require "toon"

module ToonCodec
  module_function

  def logger
    @logger ||= begin
      level = ENV.fetch("LOG_LEVEL", "info").upcase
      logger = Logger.new($stdout)
      logger.level = Logger.const_get(level) rescue Logger::INFO
      logger
    end
  end

  def encode(payload, options = nil)
    Toon.encode(payload, options)
  rescue Toon::Error => e
    logger.error("[ToonCodec] encode failed: #{e.class}: #{e.message}")
    raise
  end

  def decode(payload, options = nil)
    Toon.decode(payload, options)
  rescue Toon::Error => e
    logger.error("[ToonCodec] decode failed: #{e.class}: #{e.message}")
    raise
  end

  def decode_safe(payload, options = nil)
    result = Toon.decode_safe(payload, options)
    unless result.errors.empty?
      logger.warn("[ToonCodec] decode_safe diagnostics=#{result.diagnostics.inspect} errors=#{result.errors.inspect}")
    end
    result
  end
end


