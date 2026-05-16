// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

/// Flutter overlay for `otel_bloc`.
///
/// Re-exports the core `OTelBlocObserver` + `BlocSemantics`. A Flutter
/// app that depends on `flutter_bloc` can add this single package
/// instead of pulling in both `otel_bloc` and managing the
/// `bloc` core dependency separately.
///
/// Install once at startup:
///
/// ```dart
/// import 'package:otel_flutter_bloc/otel_flutter_bloc.dart';
///
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await DOTel.initialize(serviceName: 'my-app');
///   Bloc.observer = OTelBlocObserver();
///   runApp(const MyApp());
/// }
/// ```
///
/// See [OTelBlocObserver] in `otel_bloc` for the full
/// configuration surface and span-shape reference.
library;

export 'package:otel_bloc/otel_bloc.dart';
