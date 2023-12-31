import 'package:flutter/material.dart';

import 'pages/async_value_future_or_page.dart';

class AsyncValuePage extends StatelessWidget {
  const AsyncValuePage._();

  static const routeName = '/async_value';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AsyncValuePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncValue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(AsyncValueFutureOrPage.route());
              },
              child: const Text('FutureOr の活用'),
            ),
          ],
        ),
      ),
    );
  }
}
