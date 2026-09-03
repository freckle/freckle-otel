## [_Unreleased_](https://github.com/freckle/freckle-otel/compare/v0.0.0.3...main)

Drops support for GHC 9.2 (`lts-20`) and GHC 9.4 (`lts-21`). `hs-opentelemetry-sdk`'s OTLP
exporter now depends on a `tls`/`crypton` stack too recent to satisfy against those two
snapshots. `lts-22` (GHC 9.6) is now the oldest supported resolver.

Require `hs-opentelemetry-api` and `hs-opentelemetry-sdk` at `1.0.0.0` or later. A few behavior
changes from that upgrade are visible through this package's own functions:

- `withTracerProvider`'s shutdown now applies a default 5 second timeout instead of waiting
  indefinitely
- `inSpan`, and so `getCurrentSpanContext`, `getCurrentTraceId`, `addCurrentSpanAttributes`, and
  `withTraceContext`, no longer see the current span when the `TracerProvider` has no
  `SpanProcessor` configured (e.g. `OTEL_TRACES_EXPORTER=none`)
- `extractContext`, `injectContext`, and `processWithContext` keep propagating trace context via
  headers even when `OTEL_SDK_DISABLED=true`, where they previously became no-ops
- the `traceparent` header `injectContext`/`processWithContext` write for a sampled root span now
  has its trailing flags byte set to `03` (sampled, plus the new W3C Trace Context "random trace
  ID" bit), where it was previously `00`

## [v0.0.0.3](https://github.com/freckle/freckle-otel/compare/v0.0.0.2...v0.0.0.3)

Metadata change only; moved source repository.

## [v0.0.0.2](https://github.com/freckle/freckle-app/compare/freckle-otel-v0.0.0.1...freckle-otel-v0.0.0.2)

Update `Blammo` to 2.1

## [v0.0.0.1](https://github.com/freckle/freckle-app/compare/freckle-otel-v0.0.0.0...freckle-otel-v0.0.0.1)

Drop `relude` dependency

## [v0.0.0.0](https://github.com/freckle/freckle-app/tree/freckle-otel-v0.0.0.0/freckle-otel)

First release, sprouted from `freckle-app-1.19.0.0`.
