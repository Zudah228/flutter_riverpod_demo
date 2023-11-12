import 'package:json_annotation/json_annotation.dart';

import '../game_fighter/game_fighter.dart';

part 'game_fighter_list.g.dart';

@JsonSerializable()
class GameFighterList {
  const GameFighterList(this.list);

  @JsonKey(name: 'fighters')
  final List<GameFighter> list;

  factory GameFighterList.fromJson(Map<String, dynamic> json) =>
      _$GameFighterListFromJson(json);
}
