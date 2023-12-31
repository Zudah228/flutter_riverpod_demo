import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _parentAsyncProvider = FutureProvider.autoDispose<String>(
  (ref) => Future<void>.delayed(const Duration(seconds: 1)).then(
    (value) => 'random: ${math.Random().nextInt(99)}',
  ),
);
final _parentSyncProvider = StateProvider.autoDispose((ref) => 1);

final _child1Provider = FutureProvider.autoDispose(
  (ref) {
    final state = ref.watch(_parentSyncProvider);

    return ref.watch(_parentAsyncProvider.future).then(
          (value) => 'Child1\nparent state: $state\nparent async: $value',
        );
  },
);

final _child2Provider = FutureProvider.autoDispose<String>((ref) {
  final state = ref.watch(_parentSyncProvider);
  final asyncValue = ref.watch(_parentAsyncProvider);

  if (asyncValue is AsyncData || asyncValue is AsyncError) {
    return 'Child2\nparent state: $state\nparent async: ${asyncValue.value}';
  }

  return ref.watch(_parentAsyncProvider.future).then(
        (value) =>
            'Child2\nparent state: $state\nparent async: ${asyncValue.value}',
      );
});

class AsyncValueFutureOrPage extends ConsumerStatefulWidget {
  const AsyncValueFutureOrPage._();

  static const routeName = '/async_value_future_or';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AsyncValueFutureOrPage._(),
    );
  }

  @override
  ConsumerState<AsyncValueFutureOrPage> createState() =>
      _AsyncValueFutureOrPageState();
}

class _AsyncValueFutureOrPageState
    extends ConsumerState<AsyncValueFutureOrPage> {
  final List<dynamic> _child1Values = [];
  final List<dynamic> _child2Values = [];

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(
        _child1Provider,
        (_, next) => setState(() {
          _child1Values.add(next.runtimeType);
        }),
      )
      ..listen(
        _child2Provider,
        (_, next) => setState(() {
          _child2Values.add(next.runtimeType);
        }),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureOr の活用'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FilledButton(
                onPressed: () {
                  ref
                      .read(_parentSyncProvider.notifier)
                      .update((state) => state + 1);
                },
                child: const Text('Update Parent StateProvider'),
              ),
              FilledButton(
                onPressed: () {
                  ref.invalidate(_parentAsyncProvider);
                },
                child: const Text('Refresh Parent FutureProvider'),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ProviderBehaviorView(
                        title: 'child 1',
                        description: '分岐なしで .future で待つ',
                        color: Colors.blue,
                        value: ref.watch(_child1Provider).toString(),
                        values: _child1Values,
                      ),
                    ),
                    const VerticalDivider(
                      width: 4,
                    ),
                    Expanded(
                      child: _ProviderBehaviorView(
                        title: 'child 2',
                        description: 'AsyncValue の分岐を行う',
                        color: Colors.amber,
                        value: ref.watch(_child2Provider).toString(),
                        values: _child2Values,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProviderBehaviorView extends StatelessWidget {
  const _ProviderBehaviorView({
    required this.title,
    required this.description,
    required this.color,
    required this.value,
    required this.values,
  });

  final String title;
  final String description;
  final ColorSwatch<int> color;
  final dynamic value;
  final List<dynamic> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: color,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          color: color[100],
          child: Text(
            '$description\n\n$value',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.grey[600],
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: const Text(
            '過去に変更されたクラス',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        ...values.indexed.map(
          (e) => Container(
            alignment: Alignment.center,
            color: Colors.grey[e.$1.isEven ? 400 : 100],
            child: Text(
              e.$2.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
