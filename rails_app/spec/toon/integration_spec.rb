require "spec_helper"

RSpec.describe "Rails-style workflows using ToonCodec" do
  it "round-trips a typical Rails-style hash payload" do
    payload = {
      "user" => {
        "id" => 123,
        "email" => "user@example.com",
        "flags" => { "admin" => false, "beta" => true }
      },
      "meta" => { "request_id" => "abc-123" }
    }

    encoded = ToonCodec.encode(payload)
    decoded = ToonCodec.decode(encoded)

    expect(decoded).to eq(payload)
  end
end


