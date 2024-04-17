import 'package:flutter/material.dart';
import 'package:qreki_dart/qreki_dart.dart' as qreki;

class QrekiPage extends StatefulWidget {
  const QrekiPage._();

  static const routeName = '/qreki';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const QrekiPage._(),
    );
  }

  @override
  State<QrekiPage> createState() => _QrekiPageState();
}

class _QrekiPageState extends State<QrekiPage> {
  final _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(qreki.rokuyouFromDate(_now)),
            Text(qreki.Kyureki.fromDate(_now).toString()),
            FilledButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) {
                    return Localizations.override(
                      context: context,
                      locale: Localizations.localeOf(context),
                      child: child,
                    );
                  },
                );
              },
              child: const Text('show'),
            ),
          ],
        ),
      ),
    );
  }
}
