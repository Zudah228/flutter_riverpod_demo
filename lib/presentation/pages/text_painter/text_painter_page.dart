import 'package:flutter/material.dart';

String get _longText => String.fromCharCodes(
      List.generate(180, (index) => 12354 + index),
    );

class TextPainterPage extends StatelessWidget {
  const TextPainterPage._();

  static const routeName = '/text_painter';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TextPainterPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ! LayoutBuilder 使うのめんどくさいので、padding は設けない
    return Scaffold(
      appBar: AppBar(title: const Text('TextPainter')),
      body: Center(
        child: Column(
          children: [
            Text(
              _longText,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            const _EllipsisText(),
          ],
        ),
      ),
    );
  }
}

class _EllipsisText extends StatelessWidget {
  const _EllipsisText();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final data = _longText;
        final textPainter = TextPainter(
          text: TextSpan(text: data),
          maxLines: 3,
          textDirection: Directionality.of(context),
        )..layout(maxWidth: c.maxWidth);

        final lastPosition = textPainter.getPositionForOffset(
          Offset(textPainter.width, textPainter.height),
        );
        final lastIndex = textPainter.getOffsetBefore(lastPosition.offset);

        return Text(data.substring(0, lastIndex));
      },
    );
  }
}
