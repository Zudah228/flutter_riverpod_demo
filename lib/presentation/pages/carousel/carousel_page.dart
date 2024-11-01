import 'package:carousel_slider_x/carousel_slider_x.dart' as csx;
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../../widgets/simple_box.dart';
import 'widgets/simple_carousel.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage._();

  static const routeName = '/carousel';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CarouselPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SimpleCarousel(),
            InfiniteCarousel.builder(
              itemCount: SimpleBox.colors.length,
              itemExtent: 200,
              onIndexChanged: (index) {},
              itemBuilder: (context, itemIndex, realIndex) {
                return SimpleBox(index: itemIndex);
              },
            ),
            ExpandableCarousel(
              options: ExpandableCarouselOptions(
                autoPlay: true,
              ),
              items: SimpleBox.colors.indexed.map((e) {
                return Builder(
                  builder: (BuildContext context) {
                    return SimpleBox(
                      index: e.$1,
                    );
                  },
                );
              }).toList(),
            ),
            csx.CarouselSlider.builder(
              itemCount: SimpleBox.colors.length,
              itemBuilder: SimpleBox.infiniteItemBuilder,
              options: const csx.CarouselOptions(
                autoPlay: true,
              ),
            ),
          ].map((child) {
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
              ),
              child: SizedBox(
                height: 200,
                child: child,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
