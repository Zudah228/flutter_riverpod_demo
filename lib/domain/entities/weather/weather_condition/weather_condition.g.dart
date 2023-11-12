// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherConditionImpl _$$WeatherConditionImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherConditionImpl(
      text: json['text'] as String,
      iconUrl: const WeatherCdnUrlConverter().fromJson(json['icon'] as String),
    );

Map<String, dynamic> _$$WeatherConditionImplToJson(
        _$WeatherConditionImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'icon': const WeatherCdnUrlConverter().toJson(instance.iconUrl),
    };
