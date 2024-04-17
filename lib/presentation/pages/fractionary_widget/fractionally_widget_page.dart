import 'package:flutter/material.dart';

class FractionallyWidgetPage extends StatelessWidget {
  const FractionallyWidgetPage._();

  static const routeName = '/fractionally_widget';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FractionallyWidgetPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _SizedBox(color: Colors.indigo),
            const ClipRect(
              child: Align(
                heightFactor: 0.5,
                child: _SizedBox(color: Colors.amber),
              ),
            ),
            Transform.scale(
              scaleY: 0.5,
              child: const _SizedBox(
                color: Colors.purple,
              ),
            ),
            const FractionallySizedBox(
              heightFactor: 0.5,
              child: _SizedBox(
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizedBox extends StatelessWidget {
  const _SizedBox({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: ColoredBox(
        color: color,
        child: const Center(child: Text('AAA')),
      ),
    );
  }
}