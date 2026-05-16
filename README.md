# otel_flutter_bloc

Flutter overlay for [`otel_bloc`](../otel_bloc/README.md).

Re-exports the core `OTelBlocObserver` + `BlocSemantics` and pulls
in `flutter_bloc` so Flutter apps add **one** dependency instead of
managing `bloc` + `flutter_bloc` + `otel_bloc` separately.

```dart
import 'package:otel_flutter_bloc/otel_flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DOTel.initialize(serviceName: 'my-app');
  Bloc.observer = OTelBlocObserver();
  runApp(const MyApp());
}
```

## Choosing this vs. `otel_bloc`

- **Flutter app using `flutter_bloc`** → use this package. One
  dependency for the observer + `flutter_bloc`.
- **Pure-Dart `bloc` app (a server, CLI, isolate)** → use
  [`otel_bloc`](../otel_bloc) directly. No
  Flutter dependency.

The runtime behavior is identical — the observer is the same class
in both cases. `Bloc.observer` is a global, so a single
`Bloc.observer = OTelBlocObserver()` at app startup is the entire
install.

## What this package adds beyond re-exports

Nothing today, by design. The bloc observer install pattern is
global (`Bloc.observer = ...`), not widget-scoped, so there's no
useful `OTelBlocApp` / `OTelBlocProvider` wrapper to add. If
something widget-flavored becomes worth shipping (e.g., automatic
context propagation through `BlocProvider`-tree boundaries), it
lands here.

## License

Apache 2.0 — see `LICENSE`.
