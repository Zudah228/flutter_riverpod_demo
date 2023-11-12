import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/weather/current_weather_response/current_weather_response.dart';
import '../../repositories/weather/weather_repository.dart';

final weatherCurrentGet = Provider.autoDispose(WeatherCurrentGet.new);

class WeatherCurrentGet {
  const WeatherCurrentGet(this._ref);

  final Ref _ref;

  Future<CurrentWeatherResponse> call({required String location}) async {
    return _ref.read(weatherRepositoryProvider).currentWeather(query: location);
  }
}
