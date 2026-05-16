// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otel_flutter_bloc/otel_flutter_bloc.dart';

/// The Flutter overlay is just a re-export; this smoke test makes
/// sure the symbols downstream apps reach for (`OTelBlocObserver`,
/// `BlocSemantics`) are visible through the overlay's single import.
class _MemorySpanExporter implements SpanExporter {
  final List<Span> spans = [];
  bool _shutdown = false;

  @override
  Future<void> export(List<Span> s) async {
    if (_shutdown) return;
    spans.addAll(s);
  }

  @override
  Future<void> forceFlush() async {}

  @override
  Future<void> shutdown() async {
    _shutdown = true;
  }
}

class _Counter extends Cubit<int> {
  _Counter() : super(0);
  void inc() => emit(state + 1);
}

void main() {
  group('otel_flutter_bloc overlay', () {
    test('re-exports OTelBlocObserver and BlocSemantics', () async {
      await OTel.reset();
      final exporter = _MemorySpanExporter();
      await OTel.initialize(
        serviceName: 'flutter-bloc-otel-overlay-test',
        detectPlatformResources: false,
        spanProcessor: SimpleSpanProcessor(exporter),
      );

      // Both symbols come from the overlay's single import.
      Bloc.observer = OTelBlocObserver();
      // BlocSemantics is a typed enum — referencing it proves the
      // re-export covers the semconv layer too.
      expect(BlocSemantics.blocName.key, equals('bloc.name'));

      final c = _Counter()..inc();
      await Future<void>.delayed(Duration.zero);
      await c.close();

      expect(
        exporter.spans.any((s) => s.name.startsWith('bloc.')),
        isTrue,
        reason: 'overlay-installed observer should emit bloc.* spans',
      );

      await OTel.shutdown();
      await OTel.reset();
    });
  });
}
