# Data Model: Ruby TOON Gem

## Entities

### EncodedValue
- Description: TOON-encoded representation produced by the encoder.
- Fields:
  - `data`: String (default UTF-8, binary-safe as documented)
  - `bytes_length`: Integer (length in bytes)
  - `encoding`: Enum(`utf-8`, `ascii-8bit`) — default `utf-8`

### DecodeResult
- Description: Result of decoding a TOON input with diagnostics.
- Fields:
  - `value`: Ruby object (String, Integer, Float, TrueClass, FalseClass, NilClass, Array, Hash)
  - `diagnostics`: Array<String> (normalization notes, duplicate-key handling, special float notes)
  - `errors`: Array<String> (when using non-raising APIs)

### CodecOptions
- Description: Controls strictness and output behaviors.
- Fields:
  - `binary_output`: Boolean (default false; when true, force ASCII-8BIT for EncodedValue)
  - `reject_special_floats`: Boolean (default false; if true, decode rejects NaN/Infinity)
  - `duplicate_key_policy`: Enum(`raise`, `last_wins`) — default `raise`
  - `canonical_encode`: Boolean (default true)

## Relationships
- `encode(input, options) -> EncodedValue`
- `decode(input, options) -> value` (raising by default)
- `decode_safe(input, options) -> DecodeResult` (non-raising variant)

## Validation Rules
- Unsupported Ruby types MUST raise on encode with clear error messages.
- NaN/±Infinity MUST raise on encode; decode MAY accept per `reject_special_floats`.
- Duplicate map keys MUST raise on decode unless `duplicate_key_policy=last_wins`.

## State Transitions
- Not applicable (stateless encoding/decoding). Diagnostics are derived data.


