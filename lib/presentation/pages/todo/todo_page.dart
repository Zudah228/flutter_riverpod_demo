import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/presentation/pages/todo/widgets/todo_create_form.dart';

import 'widgets/todo_list_view.dart';

class TodoPage extends StatefulWidget {
  const TodoPage._();

  static const routeName = '/todo';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TodoPage._(),
    );
  }

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: const Column(
        children: [
          SizedBox(height: 16),
          TodoCreateForm(),
          SizedBox(height: 16),
          Expanded(child: TodoListView())
        ],
      ),
    );
  }
}
