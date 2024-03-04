import 'package:flutter/material.dart';

import 'pages/user_data_input_page.dart';

class ReactiveFormsPage extends StatefulWidget {
  const ReactiveFormsPage._();

  static const routeName = '/reactive_forms';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ReactiveFormsPage._(),
    );
  }

  @override
  State<StatefulWidget> createState() => _ReactiveFormsPageState();
}

class _ReactiveFormsPageState extends State<ReactiveFormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(UserDataInputPage.route());
              },
              child: const ListTile(title: Text('ユーザー情報')),
            ),
          ),
        ],
      ),
    );
  }
}
