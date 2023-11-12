import 'package:flutter/material.dart';

import '../../../domain/entities/game_record/game_record.dart';

class GameRecordDialog extends StatelessWidget {
  const GameRecordDialog._(this.gameRecord);

  final GameRecord gameRecord;

  static Future<bool?> show(
    BuildContext context, {
    bool barrierDismissible = true,
    required GameRecord gameRecord,
  }) {
    return showDialog<bool>(
      routeSettings: RouteSettings(arguments: gameRecord),
      barrierDismissible: barrierDismissible,
      useRootNavigator: false,
      context: context,
      builder: (_) => GameRecordDialog._(gameRecord),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            gameRecord.result.label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('自キャラ：${gameRecord.myFighter.name}'),
          Text('相手キャラ：${gameRecord.opponentFighter.name}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text(
            '保存',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
