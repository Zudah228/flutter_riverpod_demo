import 'package:flutter/material.dart';

import '../../../domain/entities/game_fighter/game_fighter.dart';
import '../../../domain/entities/game_record/game_record.dart';
import '../../../domain/entities/game_result/game_result.dart';
import '../../../utils/form_validator/form_validator.dart';
import '../../widgets/dialogs/game_record_dialog.dart';
import '../../widgets/forms/date_time_form_field.dart';
import '../../widgets/forms/radio_form_field.dart';
import '../../widgets/unfocus_gesture_detector.dart';
import 'widgets/game_fighter_form.dart';

class GameRecordPage extends StatefulWidget {
  const GameRecordPage._();

  static const routeName = '/game_record';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const GameRecordPage._(),
    );
  }

  @override
  State<GameRecordPage> createState() => _GameRecordPageState();
}

class _GameRecordPageState extends State<GameRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final _gameResultController = ValueNotifier<GameResult?>(null);

  GameFighter? _myFighter;
  GameFighter? _opponentFighter;

  void _resetForm() {
    _memoController.clear();
    _gameResultController.value = null;
    _myFighter = null;
    _opponentFighter = null;
    _formKey.currentState!.reset();

    setState(() {});
  }

  Future<void> _onSubmitted() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final selectOk = await GameRecordDialog.show(
      context,
      gameRecord: GameRecord.uuid(
        memo: _memoController.text,
        result: _gameResultController.value!,
        myFighter: _myFighter!,
        opponentFighter: _opponentFighter!,
      ),
    );

    if (!(selectOk ?? false)) {
      return;
    }

    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    final resultForm = RadioFormField<GameResult>(
      controller: _gameResultController,
      validator: formValidator.object<GameResult>().required().build(),
      items: GameResult.values
          .map(
            (value) => RadioFormFieldItem<GameResult>(
              value: value,
              label: value.label,
            ),
          )
          .toList(),
    );

    final memoForm = TextFormField(
      controller: _memoController,
      maxLines: null,
      decoration: const InputDecoration(
        label: Text('メモ'),
      ),
    );

    final myFighterForm = GameFighterForm(
      value: _myFighter,
      validator: formValidator.object<GameFighter>().required().build(),
      onChanged: (value) {
        setState(() {
          _myFighter = value;
        });
      },
      label: '自分の使用ファイター',
    );

    final opponentFighterForm = GameFighterForm(
      value: _opponentFighter,
      validator: formValidator.object<GameFighter>().required().build(),
      onChanged: (value) {
        setState(() {
          _opponentFighter = value;
        });
      },
      label: '相手の使用ファイター',
    );

    return UnfocusGestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('試合記録'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  resultForm,
                  const SizedBox(height: 16),
                  myFighterForm,
                  const SizedBox(height: 16),
                  opponentFighterForm,
                  const SizedBox(height: 16),
                  memoForm,
                  const SizedBox(height: 16),
                  DateTimeFormField(),
                  const SizedBox(height: 24),
                  FilledButton(
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                        Size.fromHeight(56),
                      ),
                    ),
                    onPressed: _onSubmitted,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
