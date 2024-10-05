import 'package:flutter/material.dart';

import '../../../widgets/simple_box.dart';

class SimpleCarousel extends StatefulWidget {
  const SimpleCarousel({super.key});

  @override
  State<StatefulWidget> createState() => _SimpleCarouselState();
}

class _SimpleCarouselState extends State<SimpleCarousel> {
  final _pageController = PageController(viewportFraction: 0.8);

  void _onTap(int index) {
    final currentPage = _pageController.page!.round();
    const duration = Duration(milliseconds: 160);
    const curve = Curves.fastOutSlowIn;

    if (index < currentPage) {
      _pageController.previousPage(duration: duration, curve: curve);
    } else if (index > currentPage) {
      _pageController.nextPage(duration: duration, curve: curve);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: SimpleBox.colors.length,
      itemBuilder: (context, index) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _onTap(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SimpleBox(index: index),
        ),
      ),
    );
  }
}
