require "spec_helper"

RSpec.describe "Toon edge cases" do
  it "handles deeply nested structures" do
    nested = { "level1" => { "level2" => { "level3" => ["a", "b", { "c" => 1 }] } } }
    expect(Toon.decode(Toon.encode(nested))).to eq(nested)
  end

  it "handles unicode strings" do
    data = { "emoji" => "😀", "combined" => "e\u0301" }
    expect(Toon.decode(Toon.encode(data))).to eq(data)
  end

  it "rejects non-string hash keys" do
    data = { Object.new => "value" }
    expect { Toon.encode(data) }.to raise_error(Toon::UnsupportedTypeError)
  end

  it "treats duplicate keys with last-wins semantics from JSON parser" do
    json = '{"key": 1, "key": 2}'
    decoded = Toon.decode(json)
    expect(decoded["key"]).to eq(2)
  end
end


