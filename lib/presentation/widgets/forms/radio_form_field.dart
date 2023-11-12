import 'package:flutter/material.dart';

class RadioFormFieldItem<T> {
  RadioFormFieldItem({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class RadioFormField<T> extends FormField<T> {
  RadioFormField({
    super.key,
    super.initialValue,
    this.controller,
    super.validator,
    super.autovalidateMode,
    this.decoration,
    required this.items,
    this.onChanged,
  }) : super(
          builder: (state) => _Builder(
            state,
            decoration: decoration,
            items: items,
            onChanged: onChanged,
          ),
        );

  final List<RadioFormFieldItem<T>> items;
  final ValueNotifier<T?>? controller;
  final ValueChanged<T?>? onChanged;
  final InputDecoration? decoration;

  @override
  FormFieldState<T> createState() {
    return _RadioFormFieldState();
  }
}

class _RadioFormFieldState<T> extends FormFieldState<T> {
  _RadioFormFieldState();

  @override
  RadioFormField<T> get widget => super.widget as RadioFormField<T>;

  @override
  void initState() {
    if (widget.controller case final controller?) {
      controller.addListener(() {
        didChange(controller.value);
      });
    }
    super.initState();
  }

  @override
  void didChange(T? value) {
    super.didChange(value);
    widget.onChanged?.call(value);
    widget.controller?.value = value;
  }

  @override
  void didUpdateWidget(covariant FormField<T> oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      widget.controller?.value = value;
      setValue(value);
    }
    super.didUpdateWidget(oldWidget);
  }
}

class _Builder<T> extends StatelessWidget {
  const _Builder(
    this.state, {
    required this.decoration,
    required this.items,
    required this.onChanged,
  });

  final FormFieldState<T> state;
  final InputDecoration? decoration;
  final List<RadioFormFieldItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    TextStyle effectiveErrorStyle() {
      final themeData = Theme.of(context);

      return decoration?.errorStyle ??
          ((themeData.textTheme.bodySmall) ?? const TextStyle()).copyWith(
            color: themeData.colorScheme.error,
          );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: items
                .map(
                  (item) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<T>(
                        value: item.value,
                        groupValue: state.value,
                        onChanged: (value) {
                          if (state.value == value) {
                            state.didChange(null);
                          } else {
                            state.didChange(value);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(item.label),
                    ],
                  ),
                )
                .toList(),
          ),
          if (state.errorText case final errorText?) ...[
            const SizedBox(height: 8),
            Text(
              errorText,
              style: effectiveErrorStyle(),
            ),
          ],
        ],
      ),
    );
  }
}
