import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';
import 'res/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      title: 'Flutter x Riverpod Demo',
      home: const HomePage(),
    );
  }
}
