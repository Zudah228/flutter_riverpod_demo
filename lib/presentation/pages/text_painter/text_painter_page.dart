import 'package:flutter/material.dart';

String get _longText => String.fromCharCodes(
      List.generate(240, (index) => 12354 + index),
    );

class TextPainterPage extends StatefulWidget {
  const TextPainterPage._();

  static const routeName = '/text_painter';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TextPainterPage._(),
    );
  }

  @override
  State<TextPainterPage> createState() => _TextPainterPageState();
}

class _TextPainterPageState extends State<TextPainterPage> {
  double _horizontalPadding = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextPainter')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(_horizontalPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <double>[0, 8, 24]
                    .map(
                      (padding) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              _horizontalPadding = padding;
                            });
                          },
                          child: Text('$padding'),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              Text(
                _longText,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              const _CustomEllipsisText(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomEllipsisText extends StatelessWidget {
  const _CustomEllipsisText();

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style;

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

        print('取得した lastPosition の文字列: "${data[lastPosition.offset]}"');

        final lastIndex = textPainter.getOffsetBefore(lastPosition.offset);

        return Text(
          data.substring(0, lastIndex),
          style: style,
        );
      },
    );
  }
}
