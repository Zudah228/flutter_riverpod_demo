import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/todo/todo.dart';

final todoSaveProvider = Provider.autoDispose<TodoSave>((_) => TodoSave());

class TodoSave {
  Future<Todo> call({required String title}) async {
    final newTodo = Todo.uuid(title: title);

    if (kDebugMode) {
      print('save todo ${newTodo.id}');
    }

    await Future<void>.delayed(const Duration(milliseconds: 700));

    return newTodo;
  }
}
