import 'package:json_annotation/json_annotation.dart';

part 'game_fighter.g.dart';

@JsonSerializable()
class GameFighter {
  const GameFighter({
    required this.id,
    required this.name,
  });

  factory GameFighter.fromJson(Map<String, dynamic> json) =>
      _$GameFighterFromJson(json);

  final String id;
  final String name;

  String toJson() => id;
}
