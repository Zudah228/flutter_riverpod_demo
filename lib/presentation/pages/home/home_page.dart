import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/presentation/pages/game_record/game_record_page.dart';

import '../todo/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final items = [
      (title: 'Todo', route: TodoPage.route),
      (title: 'MealRecord', route: GameRecordPage.route),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
          top: 32,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(item.route());
              },
              child: Center(child: Text(item.title)),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
