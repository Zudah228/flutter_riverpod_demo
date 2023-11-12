import 'package:json_annotation/json_annotation.dart';

part 'game_fighter.g.dart';

@JsonSerializable()
class GameFighter {
  const GameFighter({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory GameFighter.fromJson(Map<String, dynamic> json) =>
      _$GameFighterFromJson(json);

  String toJson() => id;
}
