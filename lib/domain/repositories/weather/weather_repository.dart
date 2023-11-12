import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_demo/domain/entities/weather/current_weather_response/current_weather_response.dart';
import 'package:flutter_riverpod_demo/domain/entities/weather/weather_error/weather_error.dart';
import 'package:http/http.dart';

import '../../../env.dart';

final weatherRepositoryProvider = Provider.autoDispose((_) {
  return WeatherRepository(
    Client(),
    apiKey: Env.weatherApiKey,
  );
});

class WeatherRepository {
  const WeatherRepository(this._client, {required this.apiKey});

  final Client _client;
  final String apiKey;

  String get _domain => 'api.weatherapi.com';

  Future<CurrentWeatherResponse> currentWeather({required String query}) async {
    final response = await _client.get(
      Uri.https(_domain, '/v1/current.json', {
        'key': apiKey,
        'q': query,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = CurrentWeatherResponse.fromJson(jsonDecode(response.body));

      if (kDebugMode) {
        print(data);
      }
      return data;
    } else {
      throw WeatherError.fromJson(jsonDecode(response.body));
    }
  }
}
