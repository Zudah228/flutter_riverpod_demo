import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/domain/entities/todo/todo.dart';

final todoRepositoryProvider = Provider.autoDispose((_) => const TodoRepository());

class TodoRepository {
  const TodoRepository();

  Future<List<Todo>> list() async {
    return [
      Todo.uuid(title: 'Element 1'),
      Todo.uuid(title: 'Element 2'),
      Todo.uuid(title: 'Element 3'),
    ];
  }
}
