import 'package:flutter/material.dart';

class FocusNodePage extends StatelessWidget {
  const FocusNodePage._();

  static const routeName = '/focus_node';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FocusNodePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: MyWidget(),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _parentFocusNode = FocusNode(debugLabel: 'parent');
  final _childFocusNode = FocusNode(debugLabel: 'child');
  final _focusNode = FocusNode(debugLabel: 'base');

  @override
  Widget build(BuildContext context) {
    print(FocusManager.instance.primaryFocus?.debugLabel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'FocusScopeNode encloses',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextSpan(
                text: '\n${FocusScope.of(context).children.length}',
              ),
            ],
          ),
        ),
        FilledButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            print(FocusManager.instance.primaryFocus?.debugLabel);
          },
          child: const Text('unfocus'),
        ),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: _focusNode,
          builder: (context, _) {
            return Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'FocusNode',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: '\n${_focusNode.toStringShort()}'
                        '\n parent: ${_focusNode.parent?.toString(minLevel: DiagnosticLevel.summary)}'
                        '\n hasFocus: ${_focusNode.hasFocus}'
                        '\n canRequestFocus: ${_focusNode.canRequestFocus}'
                        '\n hasPrimaryFocus: ${_focusNode.hasPrimaryFocus}'
                        '\n highlightMode: ${_focusNode.highlightMode}'
                        '\n rect: ${_focusNode.context == null ? null : _focusNode.rect}',
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        FocusScope(
          child: TextField(
            focusNode: _focusNode,
            decoration: const InputDecoration(
              label: Text('focus node'),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: 8),
        const TextField(
          textInputAction: TextInputAction.next,
        ),
        Focus(
          focusNode: _parentFocusNode,
          child: Focus(
            focusNode: _childFocusNode,
            child: TextButton(
              onPressed: () {
                _childFocusNode.requestFocus();

                print(_parentFocusNode.children);
                // ('child')

                print(_childFocusNode.hasPrimaryFocus);
                // 'parent'
              },
              child: const Text('print'),
            ),
          ),
        ),
      ],
    );
  }
}
