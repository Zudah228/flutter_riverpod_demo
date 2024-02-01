import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends StatelessWidget {
  const CounterPage._();

  static const routeName = '/counter';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CounterPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CounterStateful(),
            _CounterConsumer(),
          ],
        ),
      ),
    );
  }
}

class _CounterStateful extends StatefulWidget {
  const _CounterStateful();

  @override
  State<_CounterStateful> createState() => _CounterStatefulState();
}

class _CounterStatefulState extends State<_CounterStateful> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        setState(() {
          _counter++;
        });
      },
      child: Text(_counter.toString()),
    );
  }
}

final counterProvider = StateProvider.autoDispose<int>((_) => 0);

class _CounterConsumer extends ConsumerWidget {
  const _CounterConsumer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final counterController = ref.watch(counterProvider.notifier);

    return FilledButton(
      onPressed: () {
        counterController.update((state) => state + 1);
      },
      child: Text('$counter'),
    );
  }
}
