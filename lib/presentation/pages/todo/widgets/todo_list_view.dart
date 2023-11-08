import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/domain/use_cases/todo/todo_list.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListAsync = ref.watch(todoListProvider);

    return todoListAsync.when(
      data: (todoList) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList.elementAt(index);

            return ListTile(
              title: Text(todo.title),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        );
      },
      error: (e, __) {
        return Center(
          child: Text(e.toString()),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
