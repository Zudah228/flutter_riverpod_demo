import 'package:flutter/material.dart';

/// 「もっと見る」ボタンで隠せるテキスト
///
/// そもそもの表示が `minimumLines` を満たない場合、「もっと見る」ボタンは表示されない
class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.text, {
    super.key,
    this.style,
    required this.minimumLines,
    required this.overlayColor,
    this.duration = const Duration(milliseconds: 240),
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
    this.strutStyle,
    this.textDirection,
    this.textScaler,
    this.textAlign,
    this.semanticsLabel,
    this.selectionColor,
    this.locale,
  }) : assert(minimumLines > 0);

  final String text;
  final TextStyle? style;
  final Duration duration;
  final Color overlayColor;
  final int minimumLines;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis textWidthBasis;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final TextAlign? textAlign;
  final String? semanticsLabel;
  final Color? selectionColor;
  final Locale? locale;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

class ReadMoreTextState extends State<ReadMoreText> {
  final _toggleableKey = GlobalKey<_ToggleableState>();

  void toggle() {
    _toggleableKey.currentState!._toggle();
  }

  void expand() {
    _toggleableKey.currentState!._expand();
  }

  void collapse() {
    _toggleableKey.currentState!._collapse();
  }

  @override
  Widget build(BuildContext context) {
    var effectiveTextStyle = widget.style;
    if (effectiveTextStyle == null || widget.style!.inherit) {
      effectiveTextStyle =
          DefaultTextStyle.of(context).style.merge(widget.style);
    }
    if (MediaQuery.boldTextOf(context)) {
      effectiveTextStyle = effectiveTextStyle
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: effectiveTextStyle,
          ),
          textAlign: widget.textAlign ?? TextAlign.start,
          textDirection: widget.textDirection ?? Directionality.of(context),
          textScaler: widget.textScaler ?? MediaQuery.textScalerOf(context),
          locale: widget.locale,
          textHeightBehavior: widget.textHeightBehavior,
          textWidthBasis: widget.textWidthBasis,
          strutStyle: widget.strutStyle,
        )..layout(
            minWidth: constraints.minWidth,
            maxWidth: constraints.maxWidth,
          );

        final child = Text.rich(
          textPainter.text!,
          overflow: TextOverflow.visible,
          semanticsLabel: widget.semanticsLabel,
          selectionColor: widget.selectionColor,
          textHeightBehavior: textPainter.textHeightBehavior,
          textWidthBasis: textPainter.textWidthBasis,
          strutStyle: textPainter.strutStyle,
          textDirection: textPainter.textDirection,
          textScaler: textPainter.textScaler,
          textAlign: textPainter.textAlign,
          locale: widget.locale,
        );

        final lines = textPainter.computeLineMetrics();

        // 文字が minimumLines に満たない場合、「もっと見る」ボタンは非表示にする
        if (lines.length <= widget.minimumLines) {
          textPainter.dispose();

          return child;
        }

        // すべてのテキストを表示した時の高さ
        final maximumHeight = textPainter.height;

        // 隠している時の高さ
        final minimumHeight = lines.take(widget.minimumLines).fold(
              0.0,
              (previousValue, element) => previousValue + element.height,
            );

        textPainter.dispose();

        return _Toggleable(
          key: _toggleableKey,
          maximumHeight: maximumHeight,
          minimumHeight: minimumHeight,
          overlayColor: widget.overlayColor,
          minimumLines: widget.minimumLines,
          duration: widget.duration,
          child: child,
        );
      },
    );
  }
}

class _Toggleable extends StatefulWidget {
  const _Toggleable({
    super.key,
    required this.maximumHeight,
    required this.minimumHeight,
    required this.child,
    required this.overlayColor,
    required this.minimumLines,
    required this.duration,
  });

  final Widget child;
  final double maximumHeight;
  final double minimumHeight;
  final Color overlayColor;
  final int minimumLines;
  final Duration duration;

  @override
  State<_Toggleable> createState() => _ToggleableState();
}

class _ToggleableState extends State<_Toggleable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _heightFactor;
  late final Animation<double> _iconRotation;
  late final Animation<double> _overlayOpacity;

  static final _easeTween = CurveTween(curve: Curves.easeIn);

  void _toggle() {
    if (_animationController.isCompleted) {
      _collapse();
    } else {
      _expand();
    }
  }

  void _expand() {
    _animationController.forward();
  }

  void _collapse() {
    _animationController.reverse();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final heightFactorBegin = widget.minimumHeight / widget.maximumHeight;

    _heightFactor = Tween(begin: heightFactorBegin, end: 1.0)
        .chain(_easeTween)
        .animate(_animationController);
    _iconRotation = Tween(begin: 0.0, end: 0.5)
        .chain(_easeTween)
        .animate(_animationController);
    _overlayOpacity = Tween(begin: 0.0, end: 1.0)
        .chain(_easeTween)
        .animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _overlayOpacity,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  widget.overlayColor,
                  widget.overlayColor.withAlpha(255 ~/ _overlayOpacity.value),
                ],
              ).createShader,
              child: child,
            );
          },
          child: SizeTransition(
            sizeFactor: _heightFactor,
            axisAlignment: -1,
            child: widget.child,
          ),
        ),
        const SizedBox(height: 16),

        // 「もっと見る」ボタン
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _toggle,
            icon: RotationTransition(
              turns: _iconRotation,
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            label: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final text = switch (_animationController.status) {
                  AnimationStatus.completed || AnimationStatus.forward => '閉じる',
                  _ => 'もっと見る',
                };

                return Text(text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
