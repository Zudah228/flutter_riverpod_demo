import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextEditingValuePage extends StatelessWidget {
  const TextEditingValuePage._();

  static const routeName = '/text_editing_value';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TextEditingValuePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        label: const Text(
          'unfocus',
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _TextField(),
        ),
      ),
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField();

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  late final TextEditingController _textEditingController;
  final _focusNode = FocusNode();

  final _recentKeyEvent = ValueNotifier<String?>(null);

  void _listener() {
    print(_textEditingController.value);
  }

  @override
  void initState() {
    _textEditingController = TextEditingController()..addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          _recentKeyEvent.value = event.logicalKey.keyLabel;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: () {
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (timer.tick >= 10) {
                      timer.cancel();
                    } else {
                      _textEditingController.value =
                          _textEditingController.value.copyWith(
                        selection: TextSelection.collapsed(offset: timer.tick),
                      );
                    }
                  });
                },
                child: const Text('Start selection Timer'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder(
            valueListenable: _recentKeyEvent,
            builder: (context, value, child) {
              return Text(value ?? '');
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  controller: _textEditingController,
                  maxLines: null,
                ),
              ),
              // const SizedBox(width: 16),
              // FilledButton(
              //   onPressed: () {
              //     _textEditingController.value =
              //         _textEditingController.value.copyWith(
              //       text: '${_textEditingController.text}「」',
              //       selection: TextSelection.collapsed(
              //         offset: _textEditingController.text.length + 1,
              //       ),
              //     );
              //   },
              //   child: const Text('「」'),
              // ),
            ],
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder(
            valueListenable: _textEditingController,
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'baseOffset: ${value.selection.base.offset}',
                  ),
                  Text(
                    'extentOffset: ${value.selection.extent.offset}',
                  ),
                  Text(
                    'affinity: ${value.selection.affinity}',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
