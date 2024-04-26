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
    return LayoutBuilder(
      builder: (context, constraints) {
        var effectiveTextStyle = widget.style;
        if (widget.style == null || widget.style!.inherit) {
          effectiveTextStyle =
              DefaultTextStyle.of(context).style.merge(widget.style);
        }

        final textPainter = TextPainter(
          text: TextSpan(
            text: widget.text,
            style: effectiveTextStyle,
          ),
          locale: widget.locale,
          textAlign: widget.textAlign ?? TextAlign.start,
          textDirection: widget.textDirection ?? Directionality.of(context),
          textScaler: widget.textScaler ?? MediaQuery.textScalerOf(context),
          textHeightBehavior: widget.textHeightBehavior,
          textWidthBasis: widget.textWidthBasis,
          strutStyle: widget.strutStyle,
        )..layout(
            minWidth: constraints.minWidth,
            maxWidth: constraints.maxWidth,
          );

        final lines = textPainter.computeLineMetrics();

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

        // 文字が minimumLines に満たない場合、「もっと見る」ボタンは非表示にする
        if (lines.length < widget.minimumLines) {
          return child;
        }

        return _Toggleable(
          key: _toggleableKey,
          textPainter: textPainter,
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
    required this.textPainter,
    required this.child,
    required this.overlayColor,
    required this.minimumLines,
    required this.duration,
  });

  final Widget child;
  final TextPainter textPainter;
  final Color overlayColor;
  final int minimumLines;
  final Duration duration;

  @override
  State<_Toggleable> createState() => _ToggleableState();
}

class _ToggleableState extends State<_Toggleable>
    with SingleTickerProviderStateMixin {
  TextPainter get textPainter => widget.textPainter;

  late final AnimationController _animationController;
  late final Animation<double> _heightFactor;
  late final Animation<double> _iconRotation;
  late final Animation<double> _opacity;

  static final _easeTween = CurveTween(curve: Curves.easeIn);

  var _isHiding = true;

  void _toggle() {
    if (_isHiding) {
      _expand();
    } else {
      _collapse();
    }
  }

  void _expand() {
    _animationController.forward();
  }

  void _collapse() {
    _animationController.reverse();
  }

  double _computeMinimumHeightFactor() {
    // すべてのテキストを表示した時の高さ
    final maximumHeight = widget.textPainter.height;
    // 隠している時の高さ
    final minimumHeight =
        widget.minimumLines * textPainter.computeLineMetrics().first.height;

    return 1 / (maximumHeight / minimumHeight);
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        setState(() {
          _isHiding = false;
        });
      case AnimationStatus.reverse:
        setState(() {
          _isHiding = true;
        });
      case AnimationStatus.dismissed:
      case AnimationStatus.completed:
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener(_animationStatusListener);

    final begin = _computeMinimumHeightFactor();

    _heightFactor = _animationController.drive(
      Tween(begin: begin, end: 1.0).chain(_easeTween),
    );
    _iconRotation = _animationController.drive(
      Tween(begin: 0.0, end: 0.5).chain(_easeTween),
    );
    _opacity = _animationController.drive(Tween(begin: 0, end: 1));

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
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _opacity,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    widget.overlayColor,
                    widget.overlayColor.withOpacity(_opacity.value),
                  ],
                ).createShader(bounds);
              },
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
            label: Text(
              _isHiding ? 'もっと見る' : '閉じる',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
