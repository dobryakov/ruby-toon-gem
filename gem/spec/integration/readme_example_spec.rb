require "spec_helper"

RSpec.describe "README example" do
  it "encodes and decodes as documented" do
    data = { "foo" => "bar", "count" => 3 }

    encoded = Toon.encode(data)
    decoded = Toon.decode(encoded)

    expect(decoded).to eq(data)
  end
end


