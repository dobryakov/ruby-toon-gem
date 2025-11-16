require "bundler/setup"
require "toon"
require_relative "../app/lib/toon_codec"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


