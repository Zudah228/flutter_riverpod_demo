import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/todo/todo.dart';
import '../../repositories/todo/todo_repository.dart';

final todoListProvider =
    AsyncNotifierProvider.autoDispose<TodoListNotifier, Set<Todo>>(
  TodoListNotifier.new,
);

class TodoListNotifier extends AutoDisposeAsyncNotifier<Set<Todo>> {
  @override
  FutureOr<Set<Todo>> build() {
    final repository = ref.read(todoRepositoryProvider);

    return repository.list().then((value) => value.toSet());
  }

  Future<void> add(Todo todo) async {
    final current = await future;

    state = AsyncData({todo, ...current});
  }
}
