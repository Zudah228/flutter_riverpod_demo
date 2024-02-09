import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../domain/entities/todo/todo.dart';
import 'simple_reorderable_list_page.dart';

class ReorderableListPage extends StatefulWidget {
  const ReorderableListPage._();

  static const routeName = '/reorderable_todos';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ReorderableListPage._(),
    );
  }

  @override
  State<ReorderableListPage> createState() => _ReorderableListPageState();
}

class _ReorderableListPageState extends State<ReorderableListPage> {
  final _todos = [
    for (var i = 1; i <= 5; i++) Todo.uuid(title: 'Todo $i'),
  ];

  void _reorder(int oldIndex, int newIndex) {
    final removed = _todos.removeAt(oldIndex);

    if (oldIndex < newIndex) {
      _todos.insert(newIndex - 1, removed);
    } else {
      _todos.insert(newIndex, removed);
    }

    setState(() {});
  }

  void _add() {
    _todos.add(Todo.uuid(title: 'New Todo'));
    setState(() {});
  }

  ReorderItemProxyDecorator get _proxyDecorator => (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final animValue = Curves.easeInOut.transform(animation.value);
            final elevation = lerpDouble(0, 6, animValue)!;

            return Material(
              type: MaterialType.transparency,
              elevation: elevation,
              child: child,
            );
          },
          child: child,
        );
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(SimpleReorderableListPage.route());
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            sliver: SliverReorderableList(
              proxyDecorator: _proxyDecorator,
              itemBuilder: (context, index) {
                final todo = _todos[index];

                return ReorderableDragStartListener(
                  key: ValueKey(todo.id),
                  index: index,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                    ),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Text(todo.title),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _todos.length,
              onReorder: _reorder,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: IconButton(
                onPressed: _add,
                icon: const Icon(Icons.add),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              
            ),
          )
        ],
      ),
    );
  }
}
