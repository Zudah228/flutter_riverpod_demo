import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/separated_column.dart';
import '../../widgets/unfocus_gesture_detector.dart';

class DisableFormButtonPage extends StatefulWidget {
  const DisableFormButtonPage._();

  static const routeName = '/disable_form_button';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const DisableFormButtonPage._(),
    );
  }

  @override
  State<DisableFormButtonPage> createState() => _DisableFormButtonPageState();
}

class _DisableFormButtonPageState extends State<DisableFormButtonPage> {
  @override
  Widget build(BuildContext context) {
    return UnfocusGestureDetector(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
            top: 16,
          ),
          child: const Column(
            children: [
              _Example1(),
              SizedBox(height: 32),
              _Example2(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Example1 extends StatefulWidget {
  const _Example1();

  @override
  State<_Example1> createState() => _Example1State();
}

class _Example1State extends State<_Example1> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _birthDate;

  bool _isValid = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: now,
    );

    if (date != null) {
      setState(() {
        _birthDate = date;
      });

      _onFormChanged();
    }
  }

  void _save() {
    final snackBar = SnackBar(
      content: Text(
        '${_birthDate!.year}年生まれの ${_lastNameController.text}${_firstNameController.text} さん',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _validate() {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _birthDate != null;
  }

  void _onFormChanged() {
    setState(() {
      _isValid = _validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _onFormChanged,
      child: SeparatedColumn(
        gap: 16,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: '姓',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: '名',
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
          Material(
            child: InkWell(
              onTap: _pickDate,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 16),
                    if (_birthDate != null)
                      Text(DateFormat.yMMMEd().format(_birthDate!)),
                  ],
                ),
              ),
            ),
          ),
          FilledButton(
            onPressed: _isValid ? _save : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

class _Example2 extends StatefulWidget {
  const _Example2();

  @override
  State<_Example2> createState() => _Example2State();
}

class _Example2State extends State<_Example2> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _birthDate;

  final _isValidNotifier = ValueNotifier(false);

  Future<DateTime?> _pickDate() async {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: now,
    );
  }

  void _save() {
    final snackBar = SnackBar(
      content: Text(
        '${_birthDate!.year}年生まれの ${_lastNameController.text}${_firstNameController.text} さん',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _validate() {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _birthDate != null;
  }

  void _onFormChanged() {
    _isValidNotifier.value = _validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _onFormChanged,
      child: SeparatedColumn(
        gap: 16,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: '姓',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: '名',
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
          FormField<DateTime>(
            builder: (field) {
              return Material(
                child: InkWell(
                  onTap: () async {
                    final date = await _pickDate();

                    if (date != null) {
                      setState(() {
                        _birthDate = date;
                      });
                      field.didChange(date);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 16),
                        if (field.value != null)
                          Text(DateFormat.yMMMEd().format(field.value!)),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: _isValidNotifier,
            builder: (context, isValid, child) {
              return FilledButton(
                onPressed: isValid ? _save : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('保存'),
              );
            },
          ),
        ],
      ),
    );
  }
}
