import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>() {
  return use(_GlobalKeyHook<T>());
}

class _GlobalKeyHook<T extends State<StatefulWidget>>
    extends Hook<GlobalKey<T>> {
  @override
  HookState<GlobalKey<T>, Hook<GlobalKey<T>>> createState() {
    return _GlobalKeyHookState<T>();
  }
}

class _GlobalKeyHookState<T extends State<StatefulWidget>>
    extends HookState<GlobalKey<T>, Hook<GlobalKey<T>>> {
  late final _key = GlobalKey<T>();

  @override
  GlobalKey<T> build(BuildContext context) {
    return _key;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'useGlobalKey<$T>#${shortHash(_key)}';
  }
}
