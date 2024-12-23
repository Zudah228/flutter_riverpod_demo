import 'package:flutter/material.dart';

import '../../widgets/simple_box.dart';
import 'widgets/shrink_wrapping_page_view.dart';

class ShrinkWrapPageViewPage extends StatelessWidget {
  const ShrinkWrapPageViewPage._();

  static const routeName = '/shrink_wrap_page_view';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ShrinkWrapPageViewPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ShrinkWrappingPageView(
            // scrollDirection: Axis.vertical,
            children: SimpleBox.items,
          ),
        ],
      ),
    );
  }
}
