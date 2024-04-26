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
    final overlayColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReadMoreText(
                'あいうえお' * 50,
                minimumLines: 5,
                overlayColor: overlayColor,
              ),
              const SizedBox(height: 24),
              ReadMoreText(
                'あいうえお' * 13,
                minimumLines: 5,
                overlayColor: overlayColor,
              ),
              const SizedBox(height: 24),
              SelectionArea(
                child: ReadMoreText(
                  '選択可能あいうえお' * 13,
                  minimumLines: 5,
                  overlayColor: overlayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
