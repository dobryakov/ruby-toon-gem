require "spec_helper"

RSpec.describe ToonCodec do
  it "encodes and decodes payloads via Toon" do
    payload = { "name" => "RailsApp", "version" => "0.1.0", "features" => ["encode", "decode"] }

    encoded = ToonCodec.encode(payload)
    decoded = ToonCodec.decode(encoded)

    expect(decoded).to eq(payload)
  end

  it "provides decode_safe with diagnostics" do
    result = ToonCodec.decode_safe("not-json")

    expect(result.value).to be_nil
    expect(result.errors).not_to be_empty
  end
end


