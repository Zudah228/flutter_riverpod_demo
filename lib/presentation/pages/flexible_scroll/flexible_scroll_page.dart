import 'package:flutter/material.dart';

class FlexibleScrollPage extends StatelessWidget {
  const FlexibleScrollPage._();

  static const routeName = '/flexible_scroll';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FlexibleScrollPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      color: Colors.yellow,
                      height: 200,
                      child: const Center(child: Text('Dart')),
                    ),
                    const Expanded(
                      child: ColoredBox(
                        color: Colors.purple,
                        child: Center(
                          child: FlutterLogo(
                            size: 250,
                            style: FlutterLogoStyle.stacked,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
