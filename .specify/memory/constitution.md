<!--
Sync Impact Report
- Version change: N/A → 1.0.0
- Modified principles: N/A (initial ratification)
- Added sections: Core Principles (5), Architecture & Environment Constraints, Development Workflow & Quality Gates, Governance
- Removed sections: None
- Templates requiring updates:
  - ✅ Updated: .specify/templates/plan-template.md (Constitution Check gates)
  - ✅ Updated: .specify/templates/spec-template.md (Constitution constraints note)
  - ✅ Updated: .specify/templates/tasks-template.md (Tests marked REQUIRED)
  - ⚠ Pending: None
- Follow-up TODOs:
  - TODO(RATIFICATION_DATE): Project owners to provide original adoption date
-->

# ruby-toon-gem Constitution

## Core Principles

### I. Dockerized Development & Runtime (NON-NEGOTIABLE)
All development, build, test, and runtime operations MUST execute inside Docker
containers orchestrated via docker-compose. Host execution is prohibited except
for Docker/Compose/Curl and minimal bootstrap scripts. Configurable ports and
settings MUST be supplied via environment variables (no hardcoded ports).

Rationale: Ensures reproducibility, parity across machines/CI, and explicit,
auditable configuration.

### II. Real Rails Integration Testing in Separate Container
A separate Rails application container MUST be used to exercise the gem as a
real dependency via automated tests. The Rails app lifecycle (setup, migrate,
run tests) MUST be automated and runnable headlessly in CI. The gem container
and the Rails app container MUST be networked in the same compose project.

Rationale: Validates the gem in realistic conditions, preventing integration
regressions that unit tests alone cannot catch.

### III. Test-First and Automation Discipline
Tests MUST be authored before or alongside changes (red/green/refactor). Both
encoding and decoding functionality MUST be covered with representative data
types (strings, numbers, booleans, arrays, objects/records, and edge cases).
All tests MUST run inside containers, with deterministic seeds/fixtures, and be
CI-ready.

Rationale: Guarantees correctness, prevents regressions, and documents behavior.

### IV. TOON Specification Compliance
The gem MUST implement the TOON format per the standard at
https://github.com/toon-format/toon, supporting typical data types and clearly
documenting any limitations or extensions. Compatibility guarantees MUST be
stated and verified by tests.

Rationale: Standards compliance enables interoperability and user trust.

### V. Release & Distribution Readiness
The gem MUST be directly consumable from a GitHub source reference and
publishable to https://rubygems.org/ with semantic versioning. Include clear
usage examples, Dockerized quickstart, and change logs. Breaking changes MUST
follow semver MAJOR bumps with migration notes.

Rationale: Ensures users can adopt the gem reliably and understand changes.

## Architecture & Environment Constraints

- Compose-first: A top-level docker-compose file MUST declare the gem build/test
  container and the separate Rails app container, with shared networks/volumes
  as needed.
- Environment: All configuration MUST be sourced from `.env` and documented in
  `env.example`. Assume non-standard ports; never hardcode.
- Health & Diagnostics: Include simple health checks (e.g., scriptable commands)
  and structured logs sufficient for CI diagnostics.
- Rebuild vs Restart: Changes that affect dependencies or base images MUST
  trigger container rebuilds; document when rebuilds are required.

## Development Workflow & Quality Gates

- Constitution Check gates (must pass before design/implementation):
  - Work executes exclusively in containers (Docker/Compose).
  - Rails integration tests run in a separate Rails container.
  - TOON spec compliance is asserted by tests for encode/decode across typical
    data types and edge cases.
  - CI workflow runs the full containerized test suite headlessly.
  - Versioning plan and release notes exist for any visible changes.
- Code Review: Reviews MUST verify Constitution Check compliance and deny merges
  on violations without written justification and follow-up tasks.
- Observability: Test logs MUST include enough detail to diagnose failures in CI
  without interactive access.

## Governance

- Supremacy: This Constitution supersedes other process documents. Conflicts are
  resolved in favor of this document.
- Amendments: Proposals MUST include rationale, impact on templates/CI, and any
  required migrations. On acceptance, version is bumped per semantic rules and
  dependent templates are synchronized.
- Versioning Policy (for this document):
  - MAJOR: Backward-incompatible governance or principle redefinitions/removals.
  - MINOR: New principle/section or materially expanded guidance.
  - PATCH: Clarifications and non-semantic refinements.
- Compliance Reviews: PRs MUST include a checklist referencing the Constitution
  Check gates. CI MUST fail if gates are not met or unchecked.

**Version**: 1.0.0 | **Ratified**: TODO(RATIFICATION_DATE): Provide original adoption date | **Last Amended**: 2025-11-16
# [PROJECT_NAME] Constitution
<!-- Example: Spec Constitution, TaskFlow Constitution, etc. -->

## Core Principles

### [PRINCIPLE_1_NAME]
<!-- Example: I. Library-First -->
[PRINCIPLE_1_DESCRIPTION]
<!-- Example: Every feature starts as a standalone library; Libraries must be self-contained, independently testable, documented; Clear purpose required - no organizational-only libraries -->

### [PRINCIPLE_2_NAME]
<!-- Example: II. CLI Interface -->
[PRINCIPLE_2_DESCRIPTION]
<!-- Example: Every library exposes functionality via CLI; Text in/out protocol: stdin/args → stdout, errors → stderr; Support JSON + human-readable formats -->

### [PRINCIPLE_3_NAME]
<!-- Example: III. Test-First (NON-NEGOTIABLE) -->
[PRINCIPLE_3_DESCRIPTION]
<!-- Example: TDD mandatory: Tests written → User approved → Tests fail → Then implement; Red-Green-Refactor cycle strictly enforced -->

### [PRINCIPLE_4_NAME]
<!-- Example: IV. Integration Testing -->
[PRINCIPLE_4_DESCRIPTION]
<!-- Example: Focus areas requiring integration tests: New library contract tests, Contract changes, Inter-service communication, Shared schemas -->

### [PRINCIPLE_5_NAME]
<!-- Example: V. Observability, VI. Versioning & Breaking Changes, VII. Simplicity -->
[PRINCIPLE_5_DESCRIPTION]
<!-- Example: Text I/O ensures debuggability; Structured logging required; Or: MAJOR.MINOR.BUILD format; Or: Start simple, YAGNI principles -->

## [SECTION_2_NAME]
<!-- Example: Additional Constraints, Security Requirements, Performance Standards, etc. -->

[SECTION_2_CONTENT]
<!-- Example: Technology stack requirements, compliance standards, deployment policies, etc. -->

## [SECTION_3_NAME]
<!-- Example: Development Workflow, Review Process, Quality Gates, etc. -->

[SECTION_3_CONTENT]
<!-- Example: Code review requirements, testing gates, deployment approval process, etc. -->

## Governance
<!-- Example: Constitution supersedes all other practices; Amendments require documentation, approval, migration plan -->

[GOVERNANCE_RULES]
<!-- Example: All PRs/reviews must verify compliance; Complexity must be justified; Use [GUIDANCE_FILE] for runtime development guidance -->

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE] | **Last Amended**: [LAST_AMENDED_DATE]
<!-- Example: Version: 2.1.1 | Ratified: 2025-06-13 | Last Amended: 2025-07-16 -->
