import 'package:flutter/material.dart';

class ButtonStyleButtonPage extends StatefulWidget {
  const ButtonStyleButtonPage._();

  static const routeName = '/button_style_button';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ButtonStyleButtonPage._(),
    );
  }

  @override
  State<ButtonStyleButtonPage> createState() => _ButtonStyleButtonPageState();
}

class _ButtonStyleButtonPageState extends State<ButtonStyleButtonPage> {
  final _outlinedButtonStateController = WidgetStatesController();
  VoidCallback get _emptyCallback => () {};
  late VoidCallback? onPressed = _emptyCallback;
  var _selected = true;
  bool get _disabled => onPressed == null;

  void _toggleDisabled() {
    if (onPressed == null) {
      onPressed = _emptyCallback;
    } else {
      onPressed = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rootThemeData = Theme.of(context);

    return Theme(
      data: rootThemeData,
      child: Builder(
        builder: (context) {
          final themeData = Theme.of(context);

          final defaultFilledButtonStyle = FilledButton(
            onPressed: onPressed,
            child: const SizedBox.shrink(),
          ).defaultStyleOf(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('ButtonStyleButton'),
            ),
            body: Column(
              children: [
                Material(
                  type: MaterialType.button,
                  color: Colors.black12,
                  child: InkWell(
                    onTap: _toggleDisabled,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        _disabled ? 'ボタンを活性化する' : 'ボタンを非活性にする',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onPressed,
                    child: const Text('SizedBox'),
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    minimumSize: const WidgetStatePropertyAll(
                      Size(double.infinity, 40),
                    ),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  onPressed: onPressed,
                  child: const Text('minimumSize'),
                ),
                ToggleOutlinedButton(
                  onPressed: _disabled
                      ? null
                      : () {
                          setState(() {
                            _selected = !_selected;
                          });
                        },
                  selected: _selected,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return (themeData.filledButtonTheme.style ??
                                defaultFilledButtonStyle)
                            .backgroundColor
                            ?.resolve(states);
                      }

                      return (themeData.outlinedButtonTheme.style ??
                              OutlinedButton.styleFrom())
                          .backgroundColor
                          ?.resolve(states);
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return (themeData.filledButtonTheme.style ??
                                defaultFilledButtonStyle)
                            .foregroundColor
                            ?.resolve(states);
                      }

                      return (themeData.outlinedButtonTheme.style ??
                              OutlinedButton.styleFrom())
                          .foregroundColor
                          ?.resolve(states);
                    }),
                  ),
                  child: const Text('Toggle'),
                ),
                OutlinedButton(
                  statesController: _outlinedButtonStateController,
                  onPressed: _disabled
                      ? null
                      : () {
                          setState(() {
                            final removed = _outlinedButtonStateController.value
                                .remove(WidgetState.selected);
                            if (!removed) {
                              _outlinedButtonStateController.value
                                  .add(WidgetState.selected);
                            }
                          });
                        },
                  child: const Text('outline'),
                ),
                Theme(
                  data: themeData.copyWith(
                    filledButtonTheme: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      FilledButton(
                        onPressed: onPressed,
                        child: const Text('設定なし'),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(),
                        onPressed: onPressed,
                        child: const Text('設定あり'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ToggleOutlinedButton extends StatefulWidget {
  const ToggleOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    required this.selected,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final bool selected;
  final ButtonStyle? style;

  @override
  State<ToggleOutlinedButton> createState() => _ToggleOutlinedButtonState();
}

class _ToggleOutlinedButtonState extends State<ToggleOutlinedButton> {
  late final WidgetStatesController _materialStateController;

  @override
  void initState() {
    _materialStateController = WidgetStatesController(
      widget.selected ? {WidgetState.selected} : null,
    );
    super.initState();
  }

  @override
  void dispose() {
    _materialStateController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ToggleOutlinedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      if (widget.selected) {
        _materialStateController.value.add(WidgetState.selected);
      } else {
        _materialStateController.value.remove(WidgetState.selected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      statesController: _materialStateController,
      style: widget.style,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
