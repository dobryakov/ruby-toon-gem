require "spec_helper"

RSpec.describe Toon::Decoder do
  let(:decoder) { described_class.new }

  it "decodes previously encoded payloads" do
    original = {
      "items" => [1, 2, 3],
      "label" => "test",
      "nested" => { "ok" => true }
    }

    encoded = Toon.encode(original)
    decoded = decoder.decode(encoded)

    expect(decoded).to eq(original)
  end

  it "raises on malformed input" do
    expect { decoder.decode("not-json") }.to raise_error(Toon::MalformedInputError)
  end

  it "supports decode_safe without raising" do
    result = decoder.decode_safe("not-json")
    expect(result.value).to be_nil
    expect(result.errors).not_to be_empty
  end
end


