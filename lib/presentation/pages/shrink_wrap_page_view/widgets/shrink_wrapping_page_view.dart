import 'package:flutter/material.dart';

class ShrinkWrappingPageView extends StatefulWidget {
  const ShrinkWrappingPageView({
    super.key,
    required this.children,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
  });

  final List<Widget> children;
  final Axis scrollDirection;
  final bool reverse;

  @override
  State<StatefulWidget> createState() => _ShrinkWrappingPageViewState();
}

class _ShrinkWrappingPageViewState extends State<ShrinkWrappingPageView> {
  final _pageController = PageController();

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final textDirection = Directionality.of(context);
        final axisDirection = textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final axisDirection = _getDirection(context);

    return Scrollable(
      controller: _pageController,
      axisDirection: axisDirection,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, position) {
        return ShrinkWrappingViewport(
          offset: position,
          axisDirection: axisDirection,
          slivers: [
            SliverFillViewport(
              delegate: SliverChildListDelegate(widget.children),
            ),
          ],
        );
      },
    );
  }
}
