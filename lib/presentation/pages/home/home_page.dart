import 'package:flutter/material.dart';

import '../animated_bottom_navigation_bar/animated_bottom_navigation_bar_page.dart';
import '../async_value/async_value_page.dart';
import '../button_style_button/button_style_button_page.dart';
import '../carousel/carousel_page.dart';
import '../counter/counter_page.dart';
import '../custom_refresh_indicator/custom_refresh_indicator_page.dart';
import '../disable_form_button/disable_form_button_page.dart';
import '../flexible_scroll/flexible_scroll_page.dart';
import '../flutter_hooks/flutter_hooks_page.dart';
import '../focus_node/focus_node_page.dart';
import '../fractionally_widget/fractionally_widget_page.dart';
import '../game_record/game_record_page.dart';
import '../infinite_scroll_pagination/infinite_scroll_pagination_page.dart';
import '../inline_span/inline_span_page.dart';
import '../min_flex/min_flex_page.dart';
import '../qreki/qreki_page.dart';
import '../reactive_forms/reactive_forms_page.dart';
import '../read_more_text/read_more_text_page.dart';
import '../reorderable_list/reorderable_list_page.dart';
import '../scrollable_padding/scrollable_padding_page.dart';
import '../shrink_wrap_page_view/shrink_wrap_page_view_page.dart';
import '../tap_region/tap_region_page.dart';
import '../text_editing_value/text_editing_value_page.dart';
import '../text_painter/text_painter_page.dart';
import '../todo/todo_page.dart';
import '../weather/weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final items = [
      (title: 'Counter', description: 'シンプルなカウンター', route: CounterPage.route),
      (title: 'Todo', description: 'シンプルなTodo', route: TodoPage.route),
      (title: '試合記録', description: '複雑な Form', route: GameRecordPage.route),
      (title: '天気', description: 'Weather API の使用', route: WeatherPage.route),
      (
        title: 'TextPainter',
        description: 'TextPainter の動作実験',
        route: TextPainterPage.route
      ),
      (
        title: 'ButtonStyleButton',
        description: 'ButtonStyleButton の動作実験',
        route: ButtonStyleButtonPage.route,
      ),
      (
        title: 'AsyncValuePage',
        description: 'AsyncValuePage の動作実験',
        route: AsyncValuePage.route,
      ),
      (
        title: 'CustomRefreshIndicatorPage',
        description: 'CustomRefreshIndicator の動作実験',
        route: CustomRefreshIndicatorPage.route,
      ),
      (
        title: 'ReorderableListPage',
        description: 'ReorderableList の動作実験',
        route: ReorderableListPage.route,
      ),
      (
        title: '「もっと見る」',
        description: '「もっと見る」でのテキスト表示切り替え',
        route: ReadMoreTextPage.route,
      ),
      (
        title: 'reactive_forms',
        description: 'reactive_forms パッケージを試す',
        route: ReactiveFormsPage.route,
      ),
      (
        title: 'infinite_scroll_pagination',
        description: 'infinite_scroll_pagination パッケージを試す',
        route: InfiniteScrollPaginationPage.route,
      ),
      (
        title: 'fractional なウィジェットの動作確認',
        description: 'FractionallyWidget',
        route: FractionallyWidgetPage.route,
      ),
      (
        title: 'TextEditingValuePage の動作確認',
        description: 'TextEditingValuePage',
        route: TextEditingValuePage.route,
      ),
      (
        title: 'qreki_dart',
        description: 'qreki_dart パッケージを試す',
        route: QrekiPage.route,
      ),
      (
        title: 'FocusNode',
        description: 'FocusNode 全部みたい',
        route: FocusNodePage.route,
      ),
      (
        title: 'Flexible/Scroll',
        description: 'Scrollable の中で Flexible 使いたい',
        route: FlexibleScrollPage.route,
      ),
      (
        title: 'InlineSpan',
        description: 'InlineSpan と RichText の深掘り',
        route: InlineSpanPage.route,
      ),
      (
        title: 'BottomAppBar',
        description: 'BottomAppBar の Notch 触る',
        route: AnimatedBottomNavigationBarPage.route,
      ),
      (
        title: 'Carousel',
        description: 'Carousel の様々な実現方法を試す',
        route: CarouselPage.route,
      ),
      (
        title: 'ボタン非活性',
        description: 'フォームボタン非活性',
        route: DisableFormButtonPage.route,
      ),
      (
        title: 'スクロールの余白',
        description: '',
        route: ScrollablePaddingPage.route,
      ),
      (
        title: 'TapRegion',
        description: '',
        route: TapRegionPage.route,
      ),
      (
        title: 'ShrinkWrapPageView',
        description: '',
        route: ShrinkWrapPageViewPage.route,
      ),
      (
        title: 'FlutterHooksPage',
        description: '',
        route: FlutterHooksPage.route,
      ),
      (
        title: 'Flexible と MainAxisSize.min',
        description: '',
        route: MinFlexPage.route
      ),
    ].reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
          top: 32,
          bottom: MediaQuery.paddingOf(context).bottom + 16,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(item.route());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(item.description),
                      ),
                    ),
                  ),
                  Ink(
                    width: double.infinity,
                    color: themeData.colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
