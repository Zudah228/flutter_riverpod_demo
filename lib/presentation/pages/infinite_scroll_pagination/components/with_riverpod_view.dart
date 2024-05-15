part of '../infinite_scroll_pagination_page.dart';

class _WithRiverpodView extends ConsumerStatefulWidget {
  const _WithRiverpodView();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WithRiverpodViewState();
}

class _WithRiverpodViewState extends ConsumerState<_WithRiverpodView> {
  final _pagingController = PagingController<int, Todo>(
    firstPageKey: 0,
  );

  Future<void> _refresh() {
    return ref.refresh(_todoListProvider.future);
  }

  void _debugPrinter() {
    print('nextPage:${_pagingController.value.nextPageKey}');
  }

  Future<void> _fetchMore(int page) async {
    try {
      await ref.read(_todoListProvider.notifier).fetchMore(page);
    } catch (_) {}
  }

  @override
  void initState() {
    ref.listenManual(_todoListProvider, (previous, next) {
      _pagingController.value = next.when(
        data: (data) {
          final isFirstPage = data.length <= _TodoListNotifier.limit;

          int? computeNextPageKey(int length) {
            if (length % _TodoListNotifier.limit == 0) {
              return length ~/ _TodoListNotifier.limit;
            } else {
              return null;
            }
          }

          final int? nextPageKey;

          final previousValue = previous?.valueOrNull;
          // 初回取得
          if (isFirstPage || previousValue == null) {
            nextPageKey = computeNextPageKey(data.length);
          } else {
            if (!next.isLoading && previousValue.length == data.length) {
              nextPageKey = null;
            } else {
              nextPageKey = computeNextPageKey(data.length);
            }
          }

          return PagingState(
            itemList: data,
            nextPageKey: nextPageKey,
          );
        },
        error: (e, _) => PagingState(
          error: e,
          nextPageKey: _pagingController.nextPageKey,
        ),
        loading: () => const PagingState(),
      );
    });

    _pagingController
      ..addPageRequestListener(_fetchMore)
      ..addListener(_debugPrinter);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        cacheExtent: 0,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: PagedSliverList<int, Todo>.separated(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) {
                  return ListTile(
                    title: Text(item.title),
                  );
                },
              ),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
          const SliverSafeArea(sliver: SliverToBoxAdapter()),
        ],
      ),
    );
  }
}

final _todoListProvider =
    AsyncNotifierProvider.autoDispose<_TodoListNotifier, List<Todo>>(
  _TodoListNotifier.new,
);

class _TodoListNotifier extends AutoDisposeAsyncNotifier<List<Todo>> {
  static int limit = 15;
  @override
  FutureOr<List<Todo>> build() {
    return ref.watch(todoRepositoryProvider).list(limit: limit);
  }

  Future<void> fetchMore(int page) async {
    if (page == 0) {
      return;
    }
    final data = [
      ...await future,
      ...await ref.read(todoRepositoryProvider).list(page: page, limit: limit),
    ];
    state = AsyncValue.data(data);
  }
}
