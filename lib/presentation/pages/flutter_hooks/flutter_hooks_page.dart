import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'hooks/global_key.dart';

class FlutterHooksPage extends StatelessWidget {
  const FlutterHooksPage._();

  static const routeName = '/flutter_hooks';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FlutterHooksPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_hooks 試す'),
      ),
      body: const Center(
        child: Column(
          children: [
            _Key(),
          ],
        ),
      ),
    );
  }
}

class _Key extends StatefulHookWidget {
  const _Key();

  @override
  State<_Key> createState() => _KeyState();
}

class _KeyState extends State<_Key> {
  @override
  Widget build(BuildContext context) {
    final key_1 = useGlobalKey();
    final key_2 = useMemoized(GlobalKey.new);
    final key_3 = useState(GlobalKey()).value;
    final key_4 = GlobalKey();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'useGlobalKey: $key_1',
              key: key_1,
            ),
            Text(
              'useMemoized(GlobalKey.new): $key_2',
              key: key_2,
            ),
            Text(
              'useState(GlobalKey()).value: $key_3',
              key: key_3,
            ),
            Text(
              'GlobalKey(): $key_4',
              key: key_4,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('setState'),
            ),
          ],
        ),
      ),
    );
  }
}
