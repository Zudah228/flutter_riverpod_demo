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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Text(
                    'あああ',
                    style: TextStyle(backgroundColor: Colors.blue),
                  ),
                ),
                WidgetSpan(
                  child: ColoredBox(
                    color: Colors.blue,
                    child: Icon(Icons.home),
                  ),
                ),
                TextSpan(
                  text: 'あああああ',
                  style: TextStyle(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.home),
              Text(
                'あああ',
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  height: 1,
                  textBaseline: TextBaseline.alphabetic,
                ),
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
