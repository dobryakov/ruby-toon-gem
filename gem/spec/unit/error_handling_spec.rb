require "spec_helper"

RSpec.describe "Toon error handling" do
  it "uses decode_safe to capture errors instead of raising" do
    result = Toon.decode_safe("not-json")

    expect(result.value).to be_nil
    expect(result.errors).not_to be_empty
  end

  it "raises typed exceptions for decode" do
    expect { Toon.decode("not-json") }.to raise_error(Toon::MalformedInputError)
  end
end


