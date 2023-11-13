// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../converters/weather_cdn_url_converter.dart';

part 'weather_condition.freezed.dart';
part 'weather_condition.g.dart';

@freezed
class WeatherCondition with _$WeatherCondition {
  const factory WeatherCondition({
    required String text,
    @JsonKey(name: 'icon') @WeatherCdnUrlConverter() required String iconUrl,
  }) = _WeatherCondition;

  const WeatherCondition._();
  factory WeatherCondition.fromJson(Map<String, Object?> json) =>
      _$WeatherConditionFromJson(json);
}
