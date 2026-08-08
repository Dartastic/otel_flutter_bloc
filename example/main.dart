// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

/// Minimal Flutter example: initialize OTel, install the observer once
/// at startup, and run a counter Cubit. Every state change lands as a
/// `bloc.*` span carrying the [BlocSemantics] attributes.
library;

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otel_flutter_bloc/otel_flutter_bloc.dart';

/// Counter cubit: the whole state machine is one integer.
final class CounterCubit extends Cubit<int> {
  /// Starts the count at zero.
  CounterCubit() : super(0);

  /// Adds one to the current count.
  void increment() => emit(state + 1);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OTel.initialize(
    serviceName: 'flutter-bloc-otel-example',
    serviceVersion: '0.0.1',
  );

  // One global observer covers every Bloc / Cubit in the app.
  Bloc.observer = OTelBlocObserver();

  runApp(const ExampleApp());
}

/// Counter app; each tap on the FAB lands as a `bloc.change` span.
class ExampleApp extends StatelessWidget {
  /// Creates the example app.
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('otel_flutter_bloc example')),
          body: Center(
            child: BlocBuilder<CounterCubit, int>(
              builder: (context, count) => Text('count: $count'),
            ),
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
