import 'package:flutter/material.dart';

import '../../widgets/simple_box.dart';

class ScrollablePaddingPage extends StatelessWidget {
  const ScrollablePaddingPage._();

  static const routeName = '/scrollable_padding';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ScrollablePaddingPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: [
          _ListView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
          ),
          const SafeArea(child: _ListView()),
        ],
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++) SimpleBox(index: i),
          ],
        ),
      ),
    );
  }
}
