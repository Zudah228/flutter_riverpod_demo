import 'package:uuid/uuid.dart';

import '../game_fighter/game_fighter.dart';
import '../game_result/game_result.dart';

class GameRecord {
  const GameRecord({
    required this.id,
    required this.memo,
    required this.recordAt,
    required this.result,
    required this.myFighter,
    required this.opponentFighter,
  });

  factory GameRecord.uuid({
    required String memo,
    required GameResult result,
    required GameFighter myFighter,
    required GameFighter opponentFighter,
    DateTime? recordAt,
  }) =>
      GameRecord(
        id: const Uuid().v4(),
        memo: memo,
        result: result,
        recordAt: recordAt ?? DateTime.now(),
        myFighter: myFighter,
        opponentFighter: opponentFighter,
      );

  final String id;
  final GameFighter myFighter;
  final GameFighter opponentFighter;
  final String memo;
  final DateTime recordAt;
  final GameResult result;
}
