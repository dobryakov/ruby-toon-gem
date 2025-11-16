#!/usr/bin/env ruby

require "bundler/setup"
require "toon"

data = {
  "message" => "Hello, TOON!",
  "answer" => 42,
  "features" => ["encode", "decode"],
  "ok" => true
}

encoded = Toon.encode(data)
decoded = Toon.decode(encoded)

puts "Encoded: #{encoded}"
puts "Decoded: #{decoded.inspect}"


