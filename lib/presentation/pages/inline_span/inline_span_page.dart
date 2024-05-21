import 'package:flutter/material.dart';

class InlineSpanPage extends StatelessWidget {
  const InlineSpanPage._();

  static const routeName = '/inline_span';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const InlineSpanPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('InlineSpanPage')),
    );
  }
}
