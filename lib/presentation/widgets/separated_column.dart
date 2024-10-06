import 'package:flutter/material.dart';

class SeparatedColumn extends Column {
  SeparatedColumn({
    this.gap = 0,
    super.key,
    List<Widget> children = const [],
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < (children.length * 2) - 1; i++)
              i.isEven ? children[i ~/ 2] : SizedBox(height: gap),
          ],
        );

  final double gap;
}
