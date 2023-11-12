import 'package:freezed_annotation/freezed_annotation.dart';

class WeatherCdnUrlConverter implements JsonConverter<String, String> {
  const WeatherCdnUrlConverter();

  @override
  String fromJson(String json) {
    return 'https:$json';
  }

  @override
  String toJson(String object) {
    throw UnimplementedError();
  }
}
