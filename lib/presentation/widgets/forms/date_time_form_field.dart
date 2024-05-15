import 'package:flutter/material.dart';

class DateTimeFormField extends FormField<DateTime> {
  DateTimeFormField({
    super.key,
    super.initialValue,
    super.validator,
    super.autovalidateMode,
    this.decoration = const InputDecoration(),
    ValueChanged<DateTime?>? onChanged,
    VoidCallback? onEditingComplete,
  }) : super(
          builder: (state) => _Builder(
            state: state as DateTimeFormFieldState,
            decoration: decoration,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
          ),
        );

  final InputDecoration decoration;

  @override
  FormFieldState<DateTime> createState() {
    return DateTimeFormFieldState();
  }
}

class DateTimeFormFieldState extends FormFieldState<DateTime> {
  int? _year;
  int? _month;
  int? _day;
  int? get year => _year;
  int? get month => _month;
  // ignore: unnecessary_getters_setters
  int? get day => _day;

  set year(int? value) {
    _year = value;
    _day = null;
  }

  set month(int? value) {
    _month = value;
    _day = null;
  }

  set day(int? value) {
    _day = value;
  }

  @override

  /// null を追加した場合、すべて入力されている場合はリセット、途中まで入力されている場合は値を更新しない
  ///
  /// 入力に関わらず全て null にしたい場合は、reset() を利用する
  void didChange(DateTime? value) {
    if (value != null) {
      year = value.year;
      month = value.month;
      day = value.day;
    } else {
      if (year != null && month != null && day != null) {
        year = null;
        month = null;
        day = null;
      }
    }
    super.didChange(value);
  }

  @override
  void reset() {
    year = null;
    month = null;
    day = null;

    super.reset();
  }
}

class _Builder extends StatefulWidget {
  const _Builder({
    required this.decoration,
    required this.state,
    required this.onChanged,
    required this.onEditingComplete,
  });

  final DateTimeFormFieldState state;
  final InputDecoration decoration;
  final ValueChanged<DateTime?>? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  State<_Builder> createState() => _BuilderState();
}

class _BuilderState extends State<_Builder> {
  final _monthFormDropdownKey = GlobalKey<_BlockState>();
  final _dayFormDropdownKey = GlobalKey<_BlockState>();

  bool get _showDayPicker =>
      widget.state.year != null && widget.state.month != null;

  Future<void> _waitBeforeNext() =>
      Future.delayed(const Duration(milliseconds: 220));

  Future<void> _setYear(int? year) async {
    if (year == null) {
      return;
    }

    widget.state.year = year;
    widget.state.didChange(null);
    widget.onChanged?.call(null);

    await _waitBeforeNext();

    // 月が選択されていない時のみ、月のメニューを開く
    if (widget.state.month == null) {
      _monthFormDropdownKey.currentState?.showMenu();
    }
  }

  Future<void> _setMonth(int? month) async {
    if (month == null) {
      return;
    }

    widget.state.month = month;
    widget.onChanged?.call(null);
    widget.state.didChange(null);

    setState(() {});

    await _waitBeforeNext();
    _dayFormDropdownKey.currentState?.showMenu();
  }

  Future<void> Function(int? day)? get _setDay => _showDayPicker
      ? (int? day) async {
          if (day == null) {
            return;
          }

          widget.state.day = day;
          final value = DateTime(widget.state.year!, widget.state.month!, day);
          widget.onChanged?.call(value);
          widget.state.didChange(value);

          setState(() {});

          await _waitBeforeNext();
          widget.onEditingComplete?.call();
        }
      : null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveDecoration = widget.decoration.applyDefaults(
      theme.inputDecorationTheme,
    );

    return SizedBox(
      width: double.infinity,
      child: Wrap(
        runSpacing: 16,
        children: [
          _Block(
            type: DateValuePickerType.year,
            value: widget.state.year,
            effectiveDecoration: effectiveDecoration,
            suffix: const Text('年'),
            hintText: '1980',
            onChanged: _setYear,
          ),
          _Block(
            key: _monthFormDropdownKey,
            type: DateValuePickerType.month,
            value: widget.state.month,
            effectiveDecoration: effectiveDecoration,
            suffix: const Text('月'),
            hintText: '1',
            onChanged: _setMonth,
          ),
          Opacity(
            opacity: _showDayPicker ? 1.0 : 0.4,
            child: _Block(
              key: _dayFormDropdownKey,
              type: DateValuePickerType.day,
              value: widget.state.day,
              effectiveDecoration: effectiveDecoration,
              suffix: const Text('日'),
              hintText: '1',
              onChanged: _setDay,
              year: widget.state.year,
              month: widget.state.month,
            ),
          ),
        ],
      ),
    );
  }
}

enum DateValuePickerType {
  year,
  month,
  day,
  ;

  int get minValue => switch (this) {
        year => 1900,
        month => DateTime.january,
        day => 1,
      };

  int maxValue({int? year, int? month}) => switch (this) {
        DateValuePickerType.year => DateTime.now().year,
        DateValuePickerType.month => DateTime.december,
        day => year == null || month == null
            ? 1
            : DateTime(year, month + 1).add(const Duration(days: -1)).day,
      };

  int get defaultValue => switch (this) {
        year => 1980,
        month => DateTime.january,
        day => 1,
      };

  List<int> menuValues({int? year, int? month}) => [
        for (var i = minValue; i <= maxValue(year: year, month: month); i++) i,
      ];

  int get labelLength => switch (this) {
        year => 4,
        month => 2,
        day => 2,
      };
}

class _Block extends StatefulWidget {
  const _Block({
    super.key,
    required this.value,
    required this.effectiveDecoration,
    required this.suffix,
    required this.onChanged,
    required this.hintText,
    required this.type,
    this.year,
    this.month,
  });

  final DateValuePickerType type;
  final String hintText;
  final int? value;
  final InputDecoration effectiveDecoration;
  final Widget suffix;
  final ValueChanged<int?>? onChanged;
  final int? year;
  final int? month;

  @override
  State<_Block> createState() => _BlockState();
}

class _BlockState extends State<_Block> {
  final _textController = TextEditingController();
  final _menuController = MenuController();

  void showMenu() {
    _menuController.open();
  }

  @override
  void didUpdateWidget(covariant _Block oldWidget) {
    if (oldWidget.value != widget.value) {
      _textController.text = widget.value?.toString() ?? '';
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final menuValues = widget.type.menuValues(
      month: widget.month,
      year: widget.year,
    );

    return MenuAnchor(
      controller: _menuController,
      style: const MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      menuChildren: menuValues.map((e) {
        return _MenuItem<int>(
          child: Text(e.toString()),
        );
      }).toList(),
      child: TextField(
        onChanged: (value) {
          final integer = int.tryParse(value);
          if (integer != null) {
            widget.onChanged?.call(integer);
          }
        },
        decoration: InputDecoration(
          suffix: widget.suffix,
          suffixIcon: IconButton(
            onPressed: showMenu,
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}

class _MenuItem<T> extends PopupMenuItem<T> {
  const _MenuItem({required super.child});
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return _MenuItemState();
  }
}

class _MenuItemState<T> extends PopupMenuItemState<T, PopupMenuItem<T>> {
  _MenuItemState();

  @override
  void handleTap() {
    widget.onTap?.call();
  }
}
