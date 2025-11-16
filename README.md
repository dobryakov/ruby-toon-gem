# toon-rb Gem

A Ruby gem providing TOON-style encode/decode functionality with simple `encode` / `decode` APIs and containerized test setup.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem "toon-rb"
```

And then execute:

```bash
bundle install
```

### From GitHub

You can also depend on the GitHub repository (note the `gem` subdirectory):

```ruby
gem "toon-rb", git: "https://github.com/dobryakov/ruby-toon-gem", subdir: "gem"
```

### From local path (for development)

```ruby
gem "toon-rb", path: "path/to/ruby-toon-gem/gem"
```

## Usage

```ruby
require "toon"

data = {
  "message" => "Hello, TOON!",
  "answer" => 42,
  "items" => [1, 2, 3],
  "flags" => { "ok" => true, "admin" => false }
}

encoded = Toon.encode(data)
decoded = Toon.decode(encoded)

puts encoded         # TOON-encoded string (UTF-8 by default)
puts decoded.inspect # => original Ruby structure
```

### Safe decode

```ruby
result = Toon.decode_safe("not-a-valid-payload")

result.value       # => nil
result.errors      # => ["...error message..."]
result.diagnostics # => []
```

## Development

This repository is designed to run tests via Docker and `docker-compose`.

### Quickstart (docker-compose)

From the repository root:

```bash
cp env.example .env

docker-compose -f docker/compose/docker-compose.yml build
```

Run gem unit specs:

```bash
docker-compose -f docker/compose/docker-compose.yml run --rm gem sh -lc 'bundle install && bundle exec rake spec'
```

Run Rails-based specs:

```bash
docker-compose -f docker/compose/docker-compose.yml run --rm rails_app sh -lc 'bundle install && bundle exec rspec'
```

Or run both via the smoke test script:

```bash
./scripts/smoke_tests.sh
```

For more details, see `specs/001-implement-toon-gem/quickstart.md`.


