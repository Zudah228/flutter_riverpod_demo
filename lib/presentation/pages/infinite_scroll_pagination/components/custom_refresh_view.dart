part of '../infinite_scroll_pagination_page.dart';

class _CustomRefreshView extends StatefulWidget {
  const _CustomRefreshView();

  @override
  State<StatefulWidget> createState() => _CustomRefreshViewState();
}

class _CustomRefreshViewState extends State<_CustomRefreshView> {
  final _pagingController = PagingController<int, Todo>(
    firstPageKey: 0,
  );

  Future<List<Todo>> _fetch(int pageKey) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    return [
      for (var i = 1; i <= 20; i++) Todo.uuid(title: 'Todo$i'),
    ];
  }

  Future<void> _loadPage(int pageKey) async {
    final list = await _fetch(pageKey);

    _pagingController.appendPage(
      list,
      pageKey + 1,
    );
  }

  Future<void> _refresh() async {
    final list = await _fetch(0);
    _pagingController.itemList = list;
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener(_loadPage);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _refresh,
      triggerMode: IndicatorTriggerMode.anywhere,
      builder: (context, child, controller) {
        Widget buildIndicator() {
          if (controller.isDragging || controller.isArmed) {
            return const Icon(Icons.arrow_downward);
          } else {
            return Visibility.maintain(
              visible: controller.isLoading || controller.isSettling,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        return Column(
          children: [
            SizeTransition(
              sizeFactor: controller,
              child: Center(child: buildIndicator()),
            ),
            Expanded(child: child),
          ],
        );
      },
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
