## [_Unreleased_](https://github.com/freckle/freckle-otel/compare/v0.0.0.3...main)

Require `hs-opentelemetry-api` and `hs-opentelemetry-sdk` at `1.0.0.0` or later. A few behavior
changes from that upgrade are visible through this package's own functions:

- `withTracerProvider`'s shutdown now applies a default 5 second timeout instead of waiting
  indefinitely
- `inSpan`, and so `getCurrentSpanContext`, `getCurrentTraceId`, `addCurrentSpanAttributes`, and
  `withTraceContext`, no longer see the current span when the `TracerProvider` has no
  `SpanProcessor` configured (e.g. `OTEL_TRACES_EXPORTER=none`)
- `extractContext`, `injectContext`, and `processWithContext` keep propagating trace context via
  headers even when `OTEL_SDK_DISABLED=true`, where they previously became no-ops

## [v0.0.0.3](https://github.com/freckle/freckle-otel/compare/v0.0.0.2...v0.0.0.3)

Metadata change only; moved source repository.

## [v0.0.0.2](https://github.com/freckle/freckle-app/compare/freckle-otel-v0.0.0.1...freckle-otel-v0.0.0.2)

Update `Blammo` to 2.1

## [v0.0.0.1](https://github.com/freckle/freckle-app/compare/freckle-otel-v0.0.0.0...freckle-otel-v0.0.0.1)

Drop `relude` dependency

## [v0.0.0.0](https://github.com/freckle/freckle-app/tree/freckle-otel-v0.0.0.0/freckle-otel)

First release, sprouted from `freckle-app-1.19.0.0`.
