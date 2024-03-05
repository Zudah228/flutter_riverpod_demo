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

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      ref.read(_todoListProvider.notifier).fetchMore,
    );

    ref.listenManual(_todoListProvider, (previous, next) {
      _pagingController.value = next.map(
        data: (data) {
          final int? nextPageKey;
          if (previous?.value?.length case final previousLength?) {
            if (previousLength == data.value.length ||
                data.value.length ~/ _TodoListNotifier.limit ==
                    previousLength ~/ _TodoListNotifier.limit) {
              nextPageKey = null;
            } else {
              nextPageKey = data.value.length ~/ _TodoListNotifier.limit;
            }
          } else {
            nextPageKey = data.value.length ~/ _TodoListNotifier.limit;
          }

          return PagingState(
            itemList: data.value,
            nextPageKey: nextPageKey,
          );
        },
        error: (e) => PagingState(
          error: e,
          nextPageKey: _pagingController.nextPageKey,
        ),
        loading: (_) => const PagingState(),
      );
    });
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
      onRefresh: () => ref.refresh(_todoListProvider.future),
      child: CustomScrollView(
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
  static int limit = 10;
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
