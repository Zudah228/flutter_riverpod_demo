import 'package:flutter/material.dart';

import '../game_record/game_record_page.dart';
import '../todo/todo_page.dart';
import '../weather/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final items = [
      (title: 'Todo', description: 'シンプルなTodo', route: TodoPage.route),
      (title: '試合記録', description: '複雑な Form', route: GameRecordPage.route),
      (title: '天気', description: 'Weather API の使用', route: WeatherPage.route),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
          top: 32,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(item.route());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(item.description),
                      ),
                    ),
                  ),
                  Ink(
                    width: double.infinity,
                    color: themeData.colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
