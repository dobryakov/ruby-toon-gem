# Implementation Plan: [FEATURE]

**Branch**: `001-implement-toon-gem` | **Date**: 2025-11-16 | **Spec**: `/home/ubuntu/ruby-toon-gem/specs/001-implement-toon-gem/spec.md`
**Input**: Feature specification from `/specs/001-implement-toon-gem/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Implement a Ruby gem that encodes and decodes data per the TOON specification with tests and Dockerized CI/E2E. The gem exposes simple `encode`/`decode` APIs, returns UTF-8 strings by default (binary-safe), provides strictness options, and includes a Rails-based demo app used only as an internal test harness (no HTTP API). Technical approach: pure Ruby implementation with clear type mapping, canonicalizing encode, permissive decode with diagnostics, and containerized tests (including Rails-based tests) exercising the gem internally.

## Technical Context

**Language/Version**: Ruby (NEEDS CLARIFICATION exact version; propose 3.2.x)  
**Primary Dependencies**: Bundler, Rake, RSpec (runtime: none/minimal), Rails (demo app only)  
**Storage**: N/A (in-memory encoding/decoding only)  
**Testing**: RSpec for unit; Rails app tests (without HTTP endpoints) for E2E-style coverage in a separate container  
**Target Platform**: Linux containers (docker-compose; CI headless)  
**Project Type**: Single library (gem) + separate Rails demo app used as an internal test harness  
**Performance Goals**: Encode/decode ≤ 1KB payloads under 100 ms locally (FR-010)  
**Constraints**: Fully Dockerized; compose-first; no hardcoded ports; CI executes containerized test suite  
**Scale/Scope**: Library-sized codebase; demo Rails app limited to internal encode/decode tests (no HTTP API)  
**TOON Version Pin**: NEEDS CLARIFICATION (pin to latest stable tag from `toon-format/toon`)  
**Numeric Handling**: Use Integer/Float; consider `BigDecimal` for precise cases (documented) (NEEDS CLARIFICATION threshold)  
**Binary Output Option**: ASCII-8BIT variant behind `CodecOptions` (FR-016)  
**Duplicate Key Policy**: Default raise; optional `:last_wins` via `CodecOptions` (FR-019)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- The following gates derive from the repository Constitution and MUST pass:
  - All commands run inside Docker containers via docker-compose (no host runs).
  - A separate Rails application container is used to test the gem end-to-end.
  - TOON specification compliance is covered by encode/decode tests across typical data types.
  - CI executes the full containerized test suite headlessly.
  - Release/versioning plan (semver) and migration notes exist for any breaking changes.
  
Planned Compliance (pre-design):
- Compose will define `gem` and `rails_app` services on a shared network.
- Unit tests (RSpec) and Rails request specs will run in containers and in CI.
- Encode/decode test matrix will include typical types + edge cases per spec.md.
- Release workflow will package the gem with semver metadata and README guidance.

Post-Design Re-check:
- Design artifacts added: `research.md`, `data-model.md`, `quickstart.md`.
- These support the gates by defining Dockerized operation, internal Rails-based tests, and CI usage.

## Project Structure

### Documentation (this feature)

```text
specs/001-implement-toon-gem/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
docker/
├── gem.Dockerfile
├── rails.Dockerfile
└── compose/
    └── docker-compose.yml

gem/
├── lib/
│   └── toon/
│       ├── version.rb
│       ├── encoder.rb
│       ├── decoder.rb
│       ├── codec_options.rb
│       └── errors.rb
├── toon.gemspec
├── Rakefile
└── spec/
    ├── unit/
    └── integration/

rails_app/
├── Gemfile
├── config/
├── app/
│   └── lib/             # or other internal modules using the gem (no HTTP controllers)
└── spec/
    └── toon/           # Rails-based tests that exercise the gem internally
```

**Structure Decision**: Single library (gem) with a separate Rails application used as an internal test harness (no HTTP API), both orchestrated via docker-compose as per Constitution. The documentation for this feature lives under `specs/001-implement-toon-gem/`.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
