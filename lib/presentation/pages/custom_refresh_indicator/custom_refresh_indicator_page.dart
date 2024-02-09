import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicatorPage extends StatelessWidget {
  const CustomRefreshIndicatorPage._();

  static const routeName = '/custom_refresh_indicator';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CustomRefreshIndicatorPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          return Future.delayed(const Duration(seconds: 1));
        },
        onStateChanged: print,
        builder: (context, child, controller) {
          return Column(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  print(controller.value);
                  return Align(
                    heightFactor: controller.value,
                    child: child,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              ),
              Expanded(child: child),
            ],
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.blue[100 * (index + 1)],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
