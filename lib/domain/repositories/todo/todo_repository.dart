import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/todo/todo.dart';

final todoRepositoryProvider = Provider.autoDispose(
  (_) => const TodoRepository(),
);

class TodoRepository {
  const TodoRepository();

  Future<List<Todo>> list({int limit = 10, int page = 0}) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    print(page);
    final start = limit * page;
    final end = limit * (page + 1);

    if (start > _pseudoList.length) {
      return [];
    }

    return _pseudoList.sublist(start, min(end, _pseudoList.length));
  }

  static final _pseudoList = [
    for (var i = 1; i <= 24; i++) Todo.uuid(title: 'Todo$i'),
  ];
}
