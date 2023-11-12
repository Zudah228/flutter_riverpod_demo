// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../converters/date_time_converter.dart';

part 'weather_location.freezed.dart';
part 'weather_location.g.dart';


@freezed
class WeatherLocation with _$WeatherLocation {
  const factory WeatherLocation({
    required String name,
    required String region,
    required String country,
    @JsonKey(name: 'tz_id') required String timezoneId,
    required double lat,
    required double lon,
    @JsonKey(name: 'localtime_epoch')
    @DateTimeEpochConverter()
    required DateTime localtime,
  }) = _WeatherLocation;

  const WeatherLocation._();
  factory WeatherLocation.fromJson(Map<String, Object?> json) =>
      _$WeatherLocationFromJson(json);
}
