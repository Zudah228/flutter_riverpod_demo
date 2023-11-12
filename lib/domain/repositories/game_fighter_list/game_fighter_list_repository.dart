import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/game_fighter_list/game_fighter_list.dart';

final gameFighterListRepositoryProvider = Provider.autoDispose(
  (_) => const GameFighterListRepository(),
);

class GameFighterListRepository {
  const GameFighterListRepository();

  Future<GameFighterList> list() async {
    return rootBundle.loadString('assets/json/character.json').then(
          (value) => GameFighterList.fromJson(
            jsonDecode(value) as Map<String, dynamic>,
          ),
        );
  }
}
