import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_error.freezed.dart';
part 'weather_error.g.dart';

@freezed
class WeatherError with _$WeatherError implements Exception {
  factory WeatherError({
    required int code,
    required String message,
  }) = _WeatherError;
  
  factory WeatherError.fromJson(Map<String, dynamic> json) =>
      _$WeatherErrorFromJson(json['error'] as Map<String, dynamic>);
  WeatherError._();
}
