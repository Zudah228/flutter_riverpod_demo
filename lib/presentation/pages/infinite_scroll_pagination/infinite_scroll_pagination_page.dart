import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/entities/todo/todo.dart';
import '../../../domain/repositories/todo/todo_repository.dart';

part 'components/custom_refresh_view.dart';
part 'components/simple_list_view.dart';
part 'components/with_riverpod_view.dart';

class InfiniteScrollPaginationPage extends StatefulWidget {
  const InfiniteScrollPaginationPage._();

  static const routeName = '/infinite_scroll_pagination';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const InfiniteScrollPaginationPage._(),
    );
  }

  @override
  State<InfiniteScrollPaginationPage> createState() =>
      _InfiniteScrollPaginationPageState();
}

List<Widget> get _pages => const [
      _SimpleListView(),
      _CustomRefreshView(),
      _WithRiverpodView(),
    ];
List<String> get _pageNames => [
      'シンプルな ListView',
      'custom_refresh_indicator と組合せ',
      'riverpod',
    ];

class _InfiniteScrollPaginationPageState
    extends State<InfiniteScrollPaginationPage> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageNames[_index]),
        actions: [
          _PageSelectButton(
            index: _index,
            onChanged: (value) => setState(() {
              _index = value;
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PrimaryScrollController.of(context).animateTo(
            0,
            duration: const Duration(milliseconds: 240),
            curve: Curves.bounceIn,
          );
        },
        child: const Icon(Icons.keyboard_arrow_up),
      ),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
    );
  }
}

class _PageSelectButton extends StatelessWidget {
  const _PageSelectButton({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: onChanged,
      itemBuilder: (context) {
        return _pageNames.indexed
            .map(
              (e) => PopupMenuItem(
                value: e.$1,
                child: Text(e.$2),
              ),
            )
            .toList();
      },
    );
  }
}
