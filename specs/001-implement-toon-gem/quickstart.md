# Quickstart: Ruby TOON Gem (Dockerized)

## Prerequisites
- Docker and docker-compose installed on host
- No host execution of tests; use compose

## Environment
Create `.env` from template:
```bash
cp env.example .env
```
Recommended variables:
```bash
GEM_PORT=9401
RAILS_PORT=9402
```

## Build and Run
```bash
docker-compose -f docker/compose/docker-compose.yml build --no-cache
docker-compose -f docker/compose/docker-compose.yml up -d
```

## Unit Tests (Gem)
```bash
docker-compose -f docker/compose/docker-compose.yml run --rm gem rake spec
```

## E2E Tests (Rails Demo)
```bash
docker-compose -f docker/compose/docker-compose.yml run --rm rails_app bundle exec rspec
```

## Rebuild Guidance
- Change to base images or gem dependencies → rebuild `gem` container
- Change to Rails dependencies → rebuild `rails_app` container
- Use `--build` on `up` or `build` explicitly

## Health & Diagnostics
- Gem service: `docker-compose logs --tail 100 gem`
- Rails app: `docker-compose logs --tail 100 rails_app`


