import 'package:uuid/uuid.dart';

class Todo {
  const Todo({required this.id, required this.title});

  factory Todo.uuid({
    required String title,
  }) =>
      Todo(
        id: const Uuid().v4(),
        title: title,
      );

  final String id;
  final String title;

  @override
  bool operator ==(Object other) =>
      other is Todo && other.runtimeType == runtimeType && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Todo(id:$id, title:$title)';
  }

  String toStringShort() {
    return 'Todo(title:$title)';
  }
}
