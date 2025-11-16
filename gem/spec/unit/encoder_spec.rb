require "spec_helper"

RSpec.describe Toon::Encoder do
  let(:encoder) { described_class.new }

  it "encodes simple scalar types" do
    expect(Toon.decode(Toon.encode("hello"))).to eq("hello")
    expect(Toon.decode(Toon.encode(42))).to eq(42)
    expect(Toon.decode(Toon.encode(3.14))).to eq(3.14)
    expect(Toon.decode(Toon.encode(true))).to eq(true)
    expect(Toon.decode(Toon.encode(false))).to eq(false)
    expect(Toon.decode(Toon.encode(nil))).to be_nil
  end

  it "encodes arrays and hashes with round-trip integrity" do
    data = {
      "name" => "Alice",
      "age" => 30,
      "scores" => [1, 2, 3.5],
      "flags" => { "admin" => true, "active" => false },
      "nested" => [{ "id" => 1 }, { "id" => 2 }]
    }

    encoded = Toon.encode(data)
    decoded = Toon.decode(encoded)

    expect(decoded).to eq(data)
  end

  it "raises on unsupported types" do
    expect { Toon.encode(Time.now) }.to raise_error(Toon::UnsupportedTypeError)
  end

  it "raises on NaN and Infinity" do
    expect { Toon.encode(Float::NAN) }.to raise_error(Toon::SpecialFloatError)
    expect { Toon.encode(Float::INFINITY) }.to raise_error(Toon::SpecialFloatError)
  end
end


