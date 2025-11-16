# Feature Specification: Ruby TOON Gem (encode/decode, tests, publish)

**Feature Branch**: `001-implement-toon-gem`  
**Created**: 2025-11-16  
**Status**: Draft  
**Input**: User description: "You do the ruby gem accoding to the TOON standart specification https://github.com/toon-format/toon
Investigate a TOON specification before doing any work.
Provide support for typical types of the data (strings, numbers, etc..)
Provide both encoding and decoding functions.
Cover it by the automated tests on differend kinds of data.
The result should be a ready-to-use solution to use gem by github link and to publish the gem to the https://rubygems.org/"

## Constitution Constraints (must reflect in this spec)

- Solution MUST be fully Dockerized and run via docker-compose.
- End-to-end tests MUST exercise the gem via a separate Rails application container.
- TOON spec compliance MUST be addressed (encode/decode for typical data types).
- CI MUST run the containerized test suite headlessly.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Encode/decode typical data (Priority: P1)

As a Ruby developer, I can encode and decode typical TOON-supported data types (strings, numbers, booleans, null, arrays, maps) so that I can reliably serialize application data and restore it without loss.

**Why this priority**: This is the core value of the gem; without correct encode/decode the library is unusable.

**Independent Test**: Round-trip test suite where known Ruby data structures are encoded to TOON and decoded back to Ruby, asserting deep equality and spec compliance for edge cases.

**Acceptance Scenarios**:

1. **Given** a Ruby hash containing strings, integers, floats, booleans, arrays, and nested hashes, **When** it is encoded to TOON and decoded back, **Then** the result deeply equals the original structure.
2. **Given** invalid input per TOON spec (e.g., unsupported type), **When** encoding is attempted, **Then** a clear error is raised describing the violation without crashing the process.

---

### User Story 2 - Use gem via GitHub and RubyGems (Priority: P2)

As a developer, I can add the gem via a GitHub source or RubyGems, require it, and call simple encode/decode APIs following README examples to integrate quickly.

**Why this priority**: Low-friction adoption requires clear packaging and documentation.

**Independent Test**: Minimal sample project installs the gem from GitHub and RubyGems, follows README examples to encode/decode sample payloads successfully.

**Acceptance Scenarios**:

1. **Given** a fresh Ruby project, **When** I add the gem from RubyGems and run the README example, **Then** it produces the expected encoded output and decodes back to the original.
2. **Given** the GitHub repository URL, **When** I add it as a source dependency, **Then** installation succeeds and examples work as documented.

---

### User Story 3 - Confidence via spec-aligned tests (Priority: P3)

As a maintainer, I can run a comprehensive test suite (unit + E2E) that validates TOON spec compliance and typical edge cases, so regressions are caught before release.

**Why this priority**: Ensures long-term reliability and compliance.

**Independent Test**: CI executes unit tests for encode/decode and E2E tests via a demo Rails container that round-trips payloads through controller endpoints.

**Acceptance Scenarios**:

1. **Given** the repository, **When** CI runs, **Then** unit tests for encoding/decoding pass with 100% of defined round-trip cases.
2. **Given** docker-compose, **When** E2E tests run against the Rails demo app using the gem, **Then** requests round-trip payloads without data loss and return HTTP 2xx.

---

### Edge Cases

- Very large integers near TOON limits; floats with NaN/Infinity handling (match TOON rules)
- Empty arrays/maps; deeply nested structures; mixed-type arrays
- Unicode strings (emoji, combining marks); binary-like strings if applicable per spec
- Null vs undefined semantics (map missing keys vs explicit null)
- Duplicate keys in maps; key type constraints
- Invalid payloads: truncated data, wrong type tags, overflow lengths; graceful decode errors

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Provide encode API that accepts typical TOON-supported Ruby data (strings, integers, floats, booleans, nil, arrays, hashes) and returns TOON-compliant bytes/string.
- **FR-002**: Provide decode API that accepts TOON-formatted input and returns equivalent Ruby structures with preserved value semantics.
- **FR-003**: Round-trip integrity: For all supported types, `decode(encode(x))` MUST deep-equal `x` subject to TOON canonicalization rules.
- **FR-004**: Validation: Decoding MUST detect and report malformed or non-compliant inputs with descriptive error messages.
- **FR-005**: Compliance: Behavior MUST align with the referenced TOON specification for type ranges, encoding rules, and error handling.
- **FR-006**: Documentation: README MUST include installation (GitHub and RubyGems), quick-start examples, supported types matrix, and error semantics.
- **FR-007**: Packaging: Gem MUST be publishable to RubyGems with semantic versioning and license metadata.
- **FR-008**: Testing: Automated tests MUST cover typical types, nested structures, edge cases, and failure cases; CI MUST run tests headlessly.
- **FR-009**: E2E: A sample Rails container MUST demonstrate using the gem to encode/decode payloads via HTTP endpoints in docker-compose.
- **FR-010**: Performance: Typical payloads (≤ 1 KB) SHOULD encode/decode in under 100 ms on a standard developer machine.
- **FR-011**: API Stability: Public methods MUST be clearly versioned and documented to avoid breaking changes without a major version bump.
- **FR-012**: Developer Ergonomics: Provide helpful exceptions for unsupported types with guidance for conversion.
- **FR-013**: TOON Version: Compliance baseline MUST follow the latest stable tag on `toon-format/toon`.
- **FR-014**: Streaming/IO: Version 1 MUST support in-memory buffers only; streaming/IO is deferred to a later version.

### Key Entities *(include if feature involves data)*

- **EncodedValue**: The TOON-encoded representation produced by the encoder; carries bytes/length metadata.
- **DecodeResult**: Parsed Ruby structure plus diagnostics on compliance or normalization performed.
- **CodecOptions**: Optional flags for strictness, canonical encoding modes, and number handling.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of defined round-trip tests for supported types pass in CI on first release.
- **SC-002**: Developers can install the library via GitHub or RubyGems and run README examples successfully in under 5 minutes.
- **SC-003**: E2E demo application round-trips payloads through HTTP with zero data loss and all acceptance scenarios passing.
- **SC-004**: For typical payloads (≤ 1 KB), encode/decode actions complete promptly during local development (perceptibly instant under normal conditions).
