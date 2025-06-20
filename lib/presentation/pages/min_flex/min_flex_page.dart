import 'package:flutter/material.dart';

// ignore: unused_element
String get _longText => 'とっても長い名前なのでオーバーフロー対策をしないといけない';
// ignore: unused_element
String get _middleText =>
    String.fromCharCodes(List.generate(20, (index) => index + 48));
// ignore: unused_element
String get _shortText =>
    String.fromCharCodes(List.generate(4, (index) => index + 65));

class MinFlexPage extends StatelessWidget {
  const MinFlexPage._();

  static const routeName = '/min_flex';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MinFlexPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 100,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          print(constraints);
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [Text(_longText * 10)],
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(_longText),
                icon: const Icon(Icons.add),
              ),
              Container(
                color: Colors.purple,
                padding: const EdgeInsets.all(16),
                child: const _TextWithIcon(),
              ),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _TextWithIcon(),
                            SizedBox(height: 200),
                          ],
                        ),
                      ),
                      _Button(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  children: const [
                    _TextWithIcon(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: const Text('ボタン'),
      icon: const Icon(Icons.search),
    );
  }
}

class _TextWithIcon extends StatelessWidget {
  const _TextWithIcon();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.abc, color: Colors.yellow),
        const SizedBox(width: 16),
        Flexible(child: Text(_longText)),
      ],
    );
  }
}
