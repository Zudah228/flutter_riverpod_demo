import 'package:flutter/material.dart';

class SimpleBox extends StatefulWidget {
  const SimpleBox({super.key, this.index = 0});

  final int index;

  static List<Color> get colors => Colors.primaries;

  static Widget itemBuilder(BuildContext context, int index) {
    return SimpleBox(index: index);
  }

  static Widget infiniteItemBuilder(BuildContext context, int index, int realIndex) {
    return SimpleBox(index: index);
  }

  @override
  State<StatefulWidget> createState() => _SimpleBoxState();
}

class _SimpleBoxState extends State<SimpleBox> {
  late final Color color;

  @override
  void initState() {
    color = SimpleBox.colors.elementAt(widget.index % SimpleBox.colors.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: color,
    );
  }
}
