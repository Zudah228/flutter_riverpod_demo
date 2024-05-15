import 'dart:math' as math;

import 'package:flutter/material.dart';

const double _kMinimapScale = 0.3;
const double _kDefaultMaxScale = 3;

double _invertScale(double scale) => 1 / scale;

class MiniMapInteractiveViewer extends StatefulWidget {
  const MiniMapInteractiveViewer({
    required this.child,
    this.onInteractiveUpdated,
    super.key,
    this.initialAlignment,
    this.maxScale = _kDefaultMaxScale,
  });

  final Widget child;
  final void Function(bool isZooming, double scale)? onInteractiveUpdated;
  final Alignment? initialAlignment;
  final double maxScale;

  @override
  MiniMapInteractiveViewerState createState() =>
      MiniMapInteractiveViewerState();
}

class MiniMapInteractiveViewerState extends State<MiniMapInteractiveViewer> {
  final _transformationController = TransformationController();
  final _viewerKey = GlobalKey();
  final _minimapKey = GlobalKey<_MinimapState>();

  Size? _viewerSize;

  bool get _isZooming {
    return _viewerMatrix[0] != 1.0;
  }

  Matrix4 get _viewerMatrix => _transformationController.value;
  double get _viewerScale => _viewerMatrix[0];

  void reset() {
    _transformationController.value = Matrix4.identity();
  }

  void toggleZoom([Offset? position]) {
    if (!_isZooming) {
      final xPosition = (() {
        if (position == null) {
          return 0.0;
        }
        final tapPosition = position.dx * widget.maxScale;
        final limit = _viewerSize?.width ?? double.infinity;

        return math.min(tapPosition, limit) * -1;
      })();

      final yPosition = (() {
        if (position == null) {
          return 0.0;
        }
        final tapPosition = position.dy * widget.maxScale;
        final limit = _viewerSize?.height ?? double.infinity;

        return math.min(tapPosition, limit) * -1;
      })();

      transit(xPosition, yPosition, widget.maxScale);
    } else {
      reset();
    }
  }

  void transit(double x, double y, [double? scale]) {
    _transformationController.value =
        Matrix4.identity().scaled(scale ?? _viewerScale)
          ..[12] = x
          ..[13] = y;
  }

  void transitFromOffset(Offset position) {
    final xLimit = _viewerSize?.width ?? double.infinity;
    final yLimit = _viewerSize?.height ?? double.infinity;

    final xPosition = math.max(0, math.min(position.dx, xLimit)) *
        _invertScale(_viewerScale) *
        -1;
    final yPosition = math.max(0, math.min(position.dy, yLimit)) *
        _invertScale(_viewerScale) *
        -1;

    transit(xPosition, yPosition);
  }

  void transitFromAlignment(Alignment alignment) {
    final x = (() {
      final max = _viewerSize!.width / _viewerScale * -1;
      if (alignment.x > 0) {
        // right
        return max;
      } else if (alignment.x < 0) {
        // left
        return 0.0;
      } else {
        // center
        return max / 2.0;
      }
    })();

    final y = (() {
      final max = _viewerSize!.height / _viewerScale * -1;
      if (alignment.y > 0) {
        // top
        return max;
      } else if (alignment.y < 0) {
        // bottom
        return 0.0;
      } else {
        // center
        return max / 2.0;
      }
    })();

    transit(x, y, _kMinimapScale);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _viewerSize = _viewerKey.currentContext?.size;
        });

        _transformationController.addListener(() {
          if (mounted) {
            widget.onInteractiveUpdated?.call(_isZooming, _viewerMatrix[0]);
          }
          setState(() {});
        });

        if (widget.initialAlignment != null) {
          transitFromAlignment(widget.initialAlignment!);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildMiniMap() {
      final viewerSize = _viewerSize;
      // ズームインしていない場合は、表示しない
      if (viewerSize == null || !_isZooming) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
        ),
        // !バードビューは現状非表示
        child: Offstage(
          child: Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
            ),
            child: SizedBox(
              width: viewerSize.width * _kMinimapScale,
              height: viewerSize.height * _kMinimapScale,
              child: _Minimap(
                key: _minimapKey,
                viewerMatrix: _viewerMatrix,
                viewerSize: viewerSize,
                child: widget.child,
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: SizeReportingWidget(
            onSizeChange: (size) {
              setState(() {
                _viewerSize = size;
              });
            },
            child: InteractiveViewer(
              key: _viewerKey,
              transformationController: _transformationController,
              maxScale: widget.maxScale,
              child: widget.child,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: buildMiniMap(),
        ),
      ],
    );
  }
}

class _Minimap extends StatefulWidget {
  const _Minimap({
    super.key,
    required this.viewerMatrix,
    required this.viewerSize,
    required this.child,
  });

  final Matrix4 viewerMatrix;
  final Size viewerSize;
  final Widget child;

  @override
  State<_Minimap> createState() => _MinimapState();
}

class _MinimapState extends State<_Minimap> {
  double get _viewerScale => widget.viewerMatrix.storage[0];
  double get _viewerInvertedScale => 1 / _viewerScale;
  double get _viewerX => (widget.viewerMatrix.getRow(0)[3] / _viewerScale) * -1;
  double get _viewerY => (widget.viewerMatrix.getRow(1)[3] / _viewerScale) * -1;
  bool get isZooming => _viewerScale != 1.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final xRatio = widget.viewerSize.width / constraints.minWidth;
        final yRatio = widget.viewerSize.height / constraints.minHeight;

        final scale = _viewerInvertedScale;
        final x = _viewerX / xRatio;
        final y = _viewerY / yRatio;

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: IgnorePointer(child: widget.child),
            ),
            if (isZooming)
              Positioned.fill(
                child: Transform(
                  transform: Matrix4(
                    // row0
                    scale, 0, 0, 0,

                    // row1
                    0, scale, 0, 0,

                    // row2
                    0, 0, 1, 0,

                    // row3
                    x, y, 0, 1,
                  ),
                  child: _UnconstrainedAspectRatio(
                    aspectRatio: widget.viewerSize.aspectRatio,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _UnconstrainedAspectRatio extends StatelessWidget {
  const _UnconstrainedAspectRatio({
    required this.child,
    required this.aspectRatio,
  });

  final Widget child;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    // Align を挟むことで、child の RenderObjectWidget のサイズを maxWidth/maxHeight に指定する
    return Align(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: child,
      ),
    );
  }
}

class SizeReportingWidget extends StatefulWidget {
  const SizeReportingWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) {
      return;
    }
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}
