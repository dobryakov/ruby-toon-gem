---

description: "Task list for implementing the Ruby TOON Gem feature"
---

## Tasks: Ruby TOON Gem (encode/decode, tests, publish)

**Input**: Design documents from `/home/ubuntu/ruby-toon-gem/specs/001-implement-toon-gem/`  
**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `quickstart.md`

**Tests**: Automated tests are **required** (unit + integration + Rails-based container tests via docker-compose).

**Organization**: Tasks are grouped by user story so each story can be implemented and tested independently.

### Checklist Format

Every task uses:

`- [ ] TXXX [P?] [USY?] Description with file path`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Initialize repository structure, Docker setup, and environment configuration.

- [X] T001 Create base project directories `docker/`, `docker/compose/`, `gem/`, and `rails_app/` at `/home/ubuntu/ruby-toon-gem/`
- [X] T002 [P] Create base gem container definition in `/home/ubuntu/ruby-toon-gem/docker/gem.Dockerfile` targeting Ruby 3.2.x
- [X] T003 [P] Create base Rails app container definition in `/home/ubuntu/ruby-toon-gem/docker/rails.Dockerfile` targeting Ruby 3.2.x and Rails 7.1.x
- [X] T004 Create environment template with non-standard ports in `/home/ubuntu/ruby-toon-gem/env.example` (e.g., `GEM_PORT`, `RAILS_PORT`)
- [X] T005 [P] Create docker-compose configuration with `gem` and `rails_app` services in `/home/ubuntu/ruby-toon-gem/docker/compose/docker-compose.yml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before any user story work.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [X] T006 Initialize gem structure with `Gemfile`, `Rakefile`, `toon.gemspec`, and `lib/toon/version.rb` in `/home/ubuntu/ruby-toon-gem/gem/`
- [X] T007 [P] Configure RSpec for the gem in `/home/ubuntu/ruby-toon-gem/gem/spec/spec_helper.rb` and `/home/ubuntu/ruby-toon-gem/gem/.rspec`
- [X] T008 [P] Initialize Rails 7.1 demo app skeleton in `/home/ubuntu/ruby-toon-gem/rails_app/` with minimal `Gemfile`, `config/`, and `app/` structure
- [X] T009 Configure docker-compose services (volumes, networks, commands) for `gem` and `rails_app` in `/home/ubuntu/ruby-toon-gem/docker/compose/docker-compose.yml`
- [X] T010 Configure application configuration loading from `.env` in `/home/ubuntu/ruby-toon-gem/docker/compose/docker-compose.yml` and `/home/ubuntu/ruby-toon-gem/rails_app/config/database.yml` (or equivalent)
- [X] T011 Setup CI workflow skeleton to run docker-compose-based tests in `/home/ubuntu/ruby-toon-gem/.github/workflows/ci.yml`

**Checkpoint**: Foundation ready — gem, Rails app, Docker, and CI skeleton exist so user stories can start.

---

## Phase 3: User Story 1 – Encode/decode typical data (Priority: P1) 🎯 MVP

**Goal**: Provide core `encode`/`decode` APIs that support typical TOON data types with round-trip integrity.

**Independent Test**: Round-trip test suite where known Ruby structures are encoded to TOON and decoded back, asserting deep equality and spec compliance for edge cases.

### Tests for User Story 1

- [X] T012 [P] [US1] Add unit tests for encoder happy-path types (strings, integers, floats, booleans, nil, arrays, hashes) in `/home/ubuntu/ruby-toon-gem/gem/spec/unit/encoder_spec.rb`
- [X] T013 [P] [US1] Add unit tests for decoder round-trip behavior and canonicalization in `/home/ubuntu/ruby-toon-gem/gem/spec/unit/decoder_spec.rb`
- [X] T014 [P] [US1] Add unit tests for error handling (unsupported types, NaN/Infinity, malformed input) in `/home/ubuntu/ruby-toon-gem/gem/spec/unit/error_handling_spec.rb`

### Implementation for User Story 1

- [X] T015 [P] [US1] Implement typed error classes for TOON encoding/decoding failures in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/errors.rb`
- [X] T016 [P] [US1] Implement `CodecOptions` entity and defaults (binary output, special float rejection, duplicate key policy) in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/codec_options.rb`
- [X] T017 [P] [US1] Implement `Toon::Encoder` with canonical TOON encode behavior for supported Ruby types in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/encoder.rb`
- [X] T018 [P] [US1] Implement `Toon::Decoder` with permissive decode and diagnostics support in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/decoder.rb`
- [X] T019 [US1] Expose public `encode`, `decode`, and `decode_safe` APIs in `/home/ubuntu/ruby-toon-gem/gem/lib/toon.rb` and ensure they are wired into `/home/ubuntu/ruby-toon-gem/gem/toon.gemspec`

**Checkpoint**: User Story 1 is fully functional and testable independently via gem unit tests.

---

## Phase 4: User Story 2 – Use gem via GitHub and RubyGems (Priority: P2)

**Goal**: Make the gem easy to install from GitHub or RubyGems and usable via clear README examples.

**Independent Test**: Minimal sample project installs the gem from RubyGems/GitHub and runs README examples successfully.

### Tests for User Story 2

- [X] T020 [P] [US2] Create a minimal sample project consuming the gem via path/GitHub in `/home/ubuntu/ruby-toon-gem/examples/basic_usage/` with a script that runs encode/decode
- [X] T021 [P] [US2] Add integration test that executes README example code in `/home/ubuntu/ruby-toon-gem/gem/spec/integration/readme_example_spec.rb`

### Implementation for User Story 2

- [X] T022 [US2] Finalize gem metadata (name, summary, homepage, MIT license, required Ruby version) in `/home/ubuntu/ruby-toon-gem/gem/toon.gemspec`
- [X] T023 [US2] Write installation and quick-start usage sections for GitHub and RubyGems in `/home/ubuntu/ruby-toon-gem/README.md`
- [X] T024 [US2] Add Rake tasks to build and publish the gem to RubyGems in `/home/ubuntu/ruby-toon-gem/gem/Rakefile`
- [X] T025 [US2] Create changelog and versioning notes aligned with TOON spec pinning in `/home/ubuntu/ruby-toon-gem/CHANGELOG.md`

**Checkpoint**: User Story 2 is complete when developers can follow README instructions to install and use the gem.

---

## Phase 5: User Story 3 – Confidence via spec-aligned tests (Priority: P3)

**Goal**: Provide comprehensive test coverage (unit + Rails-based container tests without HTTP APIs) and CI automation to prevent regressions.

**Independent Test**: CI executes gem unit tests and Rails-based specs that exercise the gem internally via docker-compose, all passing.

### Tests for User Story 3

- [X] T026 [P] [US3] Add Rails-based specs that call the gem’s encode/decode APIs internally in `/home/ubuntu/ruby-toon-gem/rails_app/spec/toon/codec_spec.rb`
- [X] T027 [P] [US3] Add Rails integration specs that compose typical workflows using the gem (no HTTP routing) in `/home/ubuntu/ruby-toon-gem/rails_app/spec/toon/integration_spec.rb`
- [X] T028 [P] [US3] Add CI job to run gem unit specs via docker-compose in `/home/ubuntu/ruby-toon-gem/.github/workflows/ci.yml`
- [X] T029 [P] [US3] Add CI job to run Rails-based specs via docker-compose in `/home/ubuntu/ruby-toon-gem/.github/workflows/ci.yml`
- [X] T030 [P] [US3] Add smoke test script that runs both gem and Rails specs locally via a single command in `/home/ubuntu/ruby-toon-gem/scripts/smoke_tests.sh`

### Implementation for User Story 3

- [X] T031 [US3] Implement internal Rails module or service that wraps gem encode/decode usage in `/home/ubuntu/ruby-toon-gem/rails_app/app/lib/toon_codec.rb`
- [X] T032 [US3] Configure Rails app to load and use the gem from local path or installed gem in `/home/ubuntu/ruby-toon-gem/rails_app/Gemfile`
- [X] T033 [US3] Add centralized error handling and diagnostics logging for gem-related failures in `/home/ubuntu/ruby-toon-gem/rails_app/app/lib/toon_codec.rb`
- [X] T034 [US3] Configure health checks and logging options for gem and Rails services in `/home/ubuntu/ruby-toon-gem/docker/compose/docker-compose.yml`
- [X] T035 [US3] Document how to run all tests (gem + Rails) via docker-compose in `/home/ubuntu/ruby-toon-gem/README.md`

**Checkpoint**: All tests (unit and Rails-based container tests) pass locally and in CI, validating TOON spec alignment.

---

## Final Phase: Polish & Cross-Cutting Concerns

**Purpose**: Improve documentation, robustness, performance, and developer experience across stories.

- [ ] T036 [P] Refine documentation and validate quickstart commands in `/home/ubuntu/ruby-toon-gem/README.md` and `/home/ubuntu/ruby-toon-gem/specs/001-implement-toon-gem/quickstart.md`
- [X] T036 [P] Refine documentation and validate quickstart commands in `/home/ubuntu/ruby-toon-gem/README.md` and `/home/ubuntu/ruby-toon-gem/specs/001-implement-toon-gem/quickstart.md`
- [X] T037 Perform code cleanup and refactoring for clarity and maintainability in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/`
- [X] T038 [P] Add additional edge-case unit tests (deep nesting, Unicode, duplicate keys, invalid payloads) in `/home/ubuntu/ruby-toon-gem/gem/spec/unit/edge_cases_spec.rb`
- [X] T039 Optimize performance of critical encode/decode paths for ≤1KB payloads in `/home/ubuntu/ruby-toon-gem/gem/lib/toon/encoder.rb` and `/home/ubuntu/ruby-toon-gem/gem/lib/toon/decoder.rb`
- [X] T040 Review security and dependency versions, updating `Gemfile` and `rails_app/Gemfile` in `/home/ubuntu/ruby-toon-gem/gem/Gemfile` and `/home/ubuntu/ruby-toon-gem/rails_app/Gemfile`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately.
- **Foundational (Phase 2)**: Depends on Setup completion — **blocks all user stories**.
- **User Stories (Phase 3–5)**: All depend on Foundational phase completion.  
  - User Story 1 (P1) should be implemented first as the MVP.
  - User Stories 2 (P2) and 3 (P3) can proceed in parallel after User Story 1 if desired but should remain independently testable.
- **Polish (Final Phase)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Phase 2; no dependencies on other stories.
- **User Story 2 (P2)**: Can start after Phase 2; uses the public APIs from User Story 1 but remains independently testable via README and example project.
- **User Story 3 (P3)**: Can start after Phase 2; depends on User Story 1 APIs and Rails foundation, but tests (Rails-based specs and CI) should be independently runnable.

### Within Each User Story

- Tests MUST be written and observed failing before implementing or wiring production code.
- Implement core entities and options (e.g., `CodecOptions`) before encoder/decoder logic.
- Implement encoder/decoder before exposing final public APIs or Rails-based integration helpers.
- Complete the user story and its tests before moving to the next story’s implementation.

### Parallel Opportunities

- All tasks marked `[P]` can be executed in parallel when team capacity allows (different files, minimal direct dependencies).
- Setup and Foundational `[P]` tasks (T002–T003, T007–T008) can run concurrently.
- Within a user story, tests marked `[P]` and implementation tasks touching different files (e.g., encoder vs decoder) can proceed in parallel with coordination.
- User Stories 2 and 3 can be developed in parallel after User Story 1’s API has stabilized.

---

## Parallel Example: User Story 1

```bash
# Parallelizable test tasks for User Story 1:
Task: "Add unit tests for encoder happy-path types in gem/spec/unit/encoder_spec.rb"        # T012 [P] [US1]
Task: "Add unit tests for decoder round-trip behavior in gem/spec/unit/decoder_spec.rb"     # T013 [P] [US1]
Task: "Add unit tests for error handling in gem/spec/unit/error_handling_spec.rb"           # T014 [P] [US1]

# Parallelizable implementation tasks for User Story 1:
Task: "Implement typed error classes in gem/lib/toon/errors.rb"                             # T015 [P] [US1]
Task: "Implement CodecOptions in gem/lib/toon/codec_options.rb"                             # T016 [P] [US1]
Task: "Implement Toon::Encoder in gem/lib/toon/encoder.rb"                                  # T017 [P] [US1]
Task: "Implement Toon::Decoder in gem/lib/toon/decoder.rb"                                  # T018 [P] [US1]
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup.
2. Complete Phase 2: Foundational (blocks all user stories).
3. Complete Phase 3: User Story 1 (core encode/decode APIs and unit tests).
4. **Stop and validate**: Run gem unit tests via docker-compose and confirm round-trip behavior.
5. Demo or tag an initial MVP release if stable.

### Incremental Delivery

1. Deliver MVP with User Story 1 (core encode/decode).
2. Add User Story 2 to enable easy installation and packaging, then validate via example project and README tests.
3. Add User Story 3 to harden coverage with Rails-based container tests and CI, then validate via automated pipelines.
4. Apply Final Phase tasks for polish and performance tuning.

### Parallel Team Strategy

With multiple developers:

1. Collaboratively complete Setup (Phase 1) and Foundational (Phase 2).
2. Assign:
   - Developer A: User Story 1 (core encode/decode + unit tests).
   - Developer B: User Story 2 (packaging, README, example project).
   - Developer C: User Story 3 (Rails demo as internal test harness, Rails-based specs, CI).
3. Coordinate on public API stability and TOON spec pinning while keeping story tests independent.


