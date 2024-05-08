part of '../infinite_scroll_pagination_page.dart';

class _SimpleListView extends StatefulWidget {
  const _SimpleListView();

  @override
  State<StatefulWidget> createState() => _SimpleListViewState();
}

class _SimpleListViewState extends State<_SimpleListView> {
  final _pagingController = PagingController<int, Todo>(
    firstPageKey: 0,
  );

  Future<void> _fetch(int pageKey) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    const max = 20;
    _pagingController.appendPage(
      [
        for (var i = 1; i <= max; i++)
          Todo.uuid(title: 'Todo${i + (max * pageKey)}'),
      ],
      pageKey + 1,
    );
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetch);
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
      onRefresh: () => Future.sync(_pagingController.refresh),
      child: PagedListView<int, Todo>.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, _) {
            return ListTile(
              title: Text(item.title),
            );
          },
        ),
        separatorBuilder: (context, _) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
