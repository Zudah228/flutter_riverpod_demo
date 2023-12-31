import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  runApp(
    const ProviderScope(
      observers: [ProviderLogger()],
      child: App(),
    ),
  );
}

class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('Add: ${provider.runtimeType}');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('Dispose: ${provider.runtimeType}');
    super.didDisposeProvider(provider, container);
  }
}
