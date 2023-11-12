import 'package:flutter/material.dart';

import 'presentation/pages/home/home_page.dart';
import 'presentation/res/app_theme.dart';

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
