import 'package:flutter/material.dart';

const _kAnimationDuration = Duration(milliseconds: 240);

/// 「もっと見る」ボタンで隠せるテキスト
///
/// そもそもの表示が `minimumLines` を満たない場合、「もっと見る」ボタンは表示されない
class ReadMoreText extends StatelessWidget {
  const ReadMoreText(
    this.text, {
    super.key,
    this.style,
    required this.minimumLines,
    required this.overlayColor,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
    this.strutStyle,
    this.textDirection,
    this.textScaler,
    this.textAlign,
    this.semanticsLabel,
    this.selectionColor,
  });

  final String text;
  final TextStyle? style;
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var effectiveTextStyle = style;
        if (style == null || style!.inherit) {
          effectiveTextStyle = DefaultTextStyle.of(context).style.merge(style);
        }

        final textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: effectiveTextStyle,
          ),
          textAlign: textAlign ?? TextAlign.start,
          textDirection: textDirection ?? Directionality.of(context),
          textScaler: textScaler ?? MediaQuery.textScalerOf(context),
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
          strutStyle: strutStyle,
        )..layout(
            minWidth: constraints.minWidth,
            maxWidth: constraints.maxWidth,
          );

        final lines = textPainter.computeLineMetrics();

        final child = Text.rich(
          textPainter.text!,
          overflow: TextOverflow.visible,
          semanticsLabel: semanticsLabel,
          selectionColor: selectionColor,
          textHeightBehavior: textPainter.textHeightBehavior,
          textWidthBasis: textPainter.textWidthBasis,
          strutStyle: textPainter.strutStyle,
          textDirection: textPainter.textDirection,
          textScaler: textPainter.textScaler,
          textAlign: textPainter.textAlign,
        );

        // 文字が minimumLines に満たない場合、「もっと見る」ボタンは非表示にする
        if (lines.length < minimumLines) {
          return child;
        }

        return _Toggleable(
          textPainter: textPainter,
          overlayColor: overlayColor,
          minimumLines: minimumLines,
          child: child,
        );
      },
    );
  }
}

class _Toggleable extends StatefulWidget {
  const _Toggleable({
    required this.textPainter,
    required this.child,
    required this.overlayColor,
    required this.minimumLines,
  });

  final Widget child;
  final TextPainter textPainter;
  final Color overlayColor;
  final int minimumLines;

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

  void _toggleExpand() {
    setState(() {
      if (_isHiding) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      _isHiding = !_isHiding;
    });
  }

  double _computeMinimumHeightFactor() {
    // すべてのテキストを表示した時の高さ
    final maximumHeight = widget.textPainter.height;
    // 隠している時の高さ
    final minimumHeight =
        widget.minimumLines * textPainter.computeLineMetrics().first.height;

    return 1 / (maximumHeight / minimumHeight);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );

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
          child: AnimatedBuilder(
            animation: _heightFactor,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              );
            },
            child: widget.child,
          ),
        ),
        const SizedBox(height: 16),

        // 「もっと見る」ボタン
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _toggleExpand,
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
