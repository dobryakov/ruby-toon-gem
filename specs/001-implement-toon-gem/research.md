# Research: Ruby TOON Gem

## Decisions

### Ruby Version
- Decision: Ruby 3.2.x
- Rationale: Widely available, stable, performant JIT options; good ecosystem support; compatible with Rails 7.x.
- Alternatives considered: Ruby 3.3.x (newer features but may require newer base images), Ruby 3.1.x (older LTS but shorter support horizon).

### Rails Version (Demo App)
- Decision: Rails 7.1.x
- Rationale: Current stable in wide use; aligns with Ruby 3.2; container images readily available.
- Alternatives considered: Rails 7.2.x (bleeding edge), Rails 6.1.x (older, less representative).

### TOON Specification Baseline
- Decision: Pin to latest stable tag at implementation time; baseline set to v1.0.0 for this plan.
- Rationale: Ensures deterministic compliance and testing; tags provide immutable references.
- Alternatives considered: Track `main` (risks breaking changes), earlier tag (risk of missing corrections).

### Numeric Handling (Floats/NaN/Infinity)
- Decision: `encode` raises on NaN/±Infinity; `decode` accepts if spec-valid with diagnostics; strict rejection toggle via `CodecOptions`.
- Rationale: Aligns with spec.md FR-018 and user clarifications; prevents silent data corruption.
- Alternatives considered: Always accept special floats (risks non-canonical outputs), always reject (too strict for interop).

### Duplicate Map Keys
- Decision: Default raise; optional `:last_wins` policy via `CodecOptions` with diagnostic.
- Rationale: Matches FR-019; avoids ambiguity while allowing interoperability when needed.
- Alternatives considered: First-wins by default (hides later values), silent last-wins (hides data issues).

### Encoder Output Type
- Decision: UTF-8 `String` documented binary-safe by default; option for ASCII-8BIT via `CodecOptions`.
- Rationale: Matches FR-016; convenient defaults with explicit binary option.
- Alternatives considered: Always binary string (less ergonomic), always Base64 (adds overhead and scope).

### Big Number Precision
- Decision: Use Integer/Float by default; recommend `BigDecimal` at API edges if precision-critical; document guidance.
- Rationale: Keeps core simple while offering path for precision needs; Ruby `BigDecimal` is standard.
- Alternatives considered: Depend on `BigDecimal` internally (adds overhead to common path).

## Best Practices and Patterns

- Containers: Separate `gem` and `rails_app` services, shared network, explicit `.env` with non-standard ports.
- Testing: Deterministic RSpec suites; request specs in Rails; CI runs `docker-compose` workflows headlessly.
- Logging: Structured logs on errors; include diagnostics for normalization and duplicate-key handling.
- Release: Semantic versioning; changelog entries; README with GitHub and RubyGems install instructions.

## Alternatives Summary

- Tracking `main` for TOON spec was rejected due to stability concerns.
- Binary-only encoder output rejected for ergonomics; default UTF-8 string chosen with binary option.
- Strict rejection of special floats always was rejected to maintain interop on decode with clear diagnostics.


