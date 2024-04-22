import 'package:flutter/material.dart';

class FractionallyWidgetPage extends StatelessWidget {
  const FractionallyWidgetPage._();

  static const routeName = '/fractionally_widget';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FractionallyWidgetPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // FractionallySizedBox
              const Text('FractionallySizedBox'),
              const SizedBox(height: 16),
              const _SizedRowBox(
                children: [
                  _SizedBox(color: Colors.indigo),
                  FractionallySizedBox(
                    heightFactor: 0.5,
                    child: _SizedBox(
                      color: Colors.green,
                    ),
                  ),
                  ClipRect(
                    child: FractionallySizedBox(
                      heightFactor: 2,
                      child: _SizedBox(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              ColoredBox(
                color: Colors.grey[300]!,
                child: const _SizedRowBox(
                  children: [
                    _SizedBox(color: Colors.indigo),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        alignment: Alignment.centerLeft,
                        child: _SizedBox(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ColoredBox(
                color: Colors.grey[300]!,
                child: const _SizedRowBox(
                  children: [
                    _SizedBox(color: Colors.indigo),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.25,
                        alignment: Alignment.centerLeft,
                        child: _SizedBox(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    _SizedBox(color: Colors.indigo),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Align
              const Text('Align'),
              const SizedBox(height: 16),
              const _SizedRowBox(
                children: [
                  _SizedBox(color: Colors.indigo),
                  ClipRect(
                    child: Align(
                      widthFactor: 0.5,
                      child: _SizedBox(color: Colors.amber),
                    ),
                  ),
                  _SizedBox(color: Colors.indigo),
                ],
              ),
              const SizedBox(height: 24),

              // Transform.scale
              const Text('Transform.scale'),
              const SizedBox(height: 16),
              _SizedRowBox(
                children: [
                  const _SizedBox(color: Colors.indigo),
                  Transform.scale(
                    scaleX: 0.5,
                    alignment: Alignment.centerLeft,
                    child: const _SizedBox(
                      color: Colors.purple,
                    ),
                  ),
                  const _SizedBox(color: Colors.indigo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SizedBox extends StatelessWidget {
  const _SizedBox({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: ColoredBox(
        color: color,
        child: const Center(
          child: Text('ABC'),
        ),
      ),
    );
  }
}

class _SizedRowBox extends StatelessWidget {
  const _SizedRowBox({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
