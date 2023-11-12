// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_fighter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameFighterList _$GameFighterListFromJson(Map<String, dynamic> json) =>
    GameFighterList(
      (json['fighters'] as List<dynamic>)
          .map((e) => GameFighter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameFighterListToJson(GameFighterList instance) =>
    <String, dynamic>{
      'fighters': instance.list,
    };
