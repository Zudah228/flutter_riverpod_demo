import 'package:flutter/material.dart';

import 'widgets/read_more_text.dart';

class ReadMoreTextPage extends StatelessWidget {
  const ReadMoreTextPage._();

  static const routeName = '/read_more_text';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ReadMoreTextPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: ReadMoreText(
            'あいうえお' * 100,
            minimumLines: 5,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
