import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/simple_box.dart';

class TapRegionPage extends StatelessWidget {
  const TapRegionPage._();

  static const routeName = '/tap_region';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TapRegionPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _Field(),
            GestureDetector(
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.all(24),
              ),
            ),
            const _Counter(),
            const SimpleBox(),
            const SimpleBox(),
            const SimpleBox(),
            const SimpleBox(),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatefulWidget {
  const _Field();

  @override
  State<_Field> createState() => _FieldState();
}

class _FieldState extends State<_Field> {
  final _textEditingController = TextEditingController();

  void _increase() {
    if (int.tryParse(_textEditingController.text) case final asNumber?) {
      _textEditingController.text = '${asNumber + 1}';
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 240,
          child: TextField(
            controller: _textEditingController,
          ),
        ),
        const SizedBox(width: 16),
        TextFieldTapRegion(
          child: OutlinedButton(
            onPressed: _increase,
            child: const Text('+1'),
          ),
        ),
      ],
    );
  }
}

class _Counter extends HookWidget {
  const _Counter();

  @override
  Widget build(BuildContext context) {
    final count = useState(1);

    final ValueNotifier<Iterable<dynamic>> v;

    if (count.value.isEven) {
      v = useState({});
    } else {
      v = useState([]);
    }

    print(count.value.isEven);
    print(v.value);

    return TextButton.icon(
      icon: const Icon(Icons.add),
      label: Text(count.value.toString()),
      onPressed: () {
        count.value++;
      },
    );
  }
}
