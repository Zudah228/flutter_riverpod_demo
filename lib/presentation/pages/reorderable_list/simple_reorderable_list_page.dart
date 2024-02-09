import 'package:flutter/material.dart';

import '../../../domain/entities/todo/todo.dart';

class SimpleReorderableListPage extends StatefulWidget {
  const SimpleReorderableListPage._();

  static const routeName = '/simple_reorderable_list';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SimpleReorderableListPage._(),
    );
  }

  @override
  State<SimpleReorderableListPage> createState() =>
      _SimpleReorderableListPageState();
}

class _SimpleReorderableListPageState extends State<SimpleReorderableListPage> {
  final _todos = [
    for (var i = 1; i <= 5; i++) Todo.uuid(title: 'Todo $i'),
  ];

  void _reorder(int oldIndex, int newIndex) {
    final removed = _todos.removeAt(oldIndex);
    _todos.insert(newIndex - 1, removed);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final todo = _todos[index];

          return Material(
            key: ValueKey(todo.id),
            type: MaterialType.transparency,
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              title: Text(todo.title),
            ),
          );
        },
        itemCount: _todos.length,
        onReorder: _reorder,
      ),
    );
  }
}
