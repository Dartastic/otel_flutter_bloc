# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0-beta.1] - 2026-05-16

### Added

- Slim Flutter overlay for `dartastic_bloc_otel`. Re-exports the
  core observer + semantics and pulls in `flutter_bloc` so Flutter
  apps add one dependency instead of managing `bloc` +
  `flutter_bloc` + `dartastic_bloc_otel` separately.
- Targets `flutter_bloc: ^9.0.0`. No new types yet — the bloc
  observer install pattern is global (`Bloc.observer = ...`), not
  widget-scoped, so there's no `OTelBlocApp`-style widget to add.
  The package exists for the dependency-mapping convenience and
  to match the `dartastic_flutter_riverpod_otel` core/overlay
  pattern.

### Note

This is a new package created when `dartastic_flutter_bloc_otel`
(the package previously published under this name) was renamed to
`dartastic_bloc_otel`. The previous package was the pure-Dart core
that only depended on `bloc`; the name was misleading. Flutter apps
that were depending on the old `dartastic_flutter_bloc_otel` can
keep using it — the surface is now provided by this overlay, which
re-exports the core and adds `flutter_bloc` as a dependency.
