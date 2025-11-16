#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

echo "[smoke] Running gem specs..."
docker-compose -f docker/compose/docker-compose.yml run --rm gem sh -lc 'bundle install && bundle exec rake spec'

echo "[smoke] Running Rails specs..."
docker-compose -f docker/compose/docker-compose.yml run --rm rails_app sh -lc 'bundle install && bundle exec rspec'

echo "[smoke] All smoke tests passed."


