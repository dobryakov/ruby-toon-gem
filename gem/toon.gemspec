Gem::Specification.new do |spec|
  spec.name          = "toon"
  spec.version       = "0.1.0"
  spec.authors       = ["Ruby TOON Gem"]
  spec.email         = ["grigoriydobryakov@gmail.com"]

  spec.summary       = "TOON encoder/decoder for Ruby"
  spec.description   = "A Ruby gem providing TOON encode/decode functionality with spec-aligned behavior."
  spec.homepage      = "https://github.com/dobryakov/ruby-toon-gem"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.2.0"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    Dir["lib/**/*", "LICENSE", "README.md"]
  end
  spec.require_paths = ["lib"]

  spec.metadata = {
    "source_code_uri" => spec.homepage
  }
end


