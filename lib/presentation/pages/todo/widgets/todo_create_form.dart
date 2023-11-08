import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/domain/use_cases/todo/todo_list.dart';
import 'package:flutter_riverpod_demo/domain/use_cases/todo/todo_save.dart';
import 'package:form_validator/form_validator.dart';

class TodoCreateForm extends ConsumerStatefulWidget {
  const TodoCreateForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoCreateFormState();
}

class _TodoCreateFormState extends ConsumerState<TodoCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  Future<void> _onSubmitted() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    try {
      if (!_formKey.currentState!.validate()) {
        throw const FormatException('入力を確認してください');
      }

      final title = _titleController.text;

      // Create をサーバーへ送信
      final savedTodo = await ref.read(todoSaveProvider)(
        title: title,
      );

      // ローカルの state を更新
      ref.read(todoListProvider.notifier).add(savedTodo);

      _titleController.clear();
    } on FormatException catch (e) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.error,
        content: Text(e.message),
      );

      scaffoldMessenger.showSnackBar(snackBar);
    } on Exception {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.error,
        content: const Text('予期せぬエラーです'),
      );

      scaffoldMessenger.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: _titleController,
                validator: ValidationBuilder().required().build(),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                onEditingComplete: _onSubmitted,
              ),
            ),
            const SizedBox(width: 8),
            Center(
              child: FilledButton(
                onPressed: _onSubmitted,
                child: const Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
