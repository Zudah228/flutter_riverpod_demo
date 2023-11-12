// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentWeatherResponseImpl _$$CurrentWeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CurrentWeatherResponseImpl(
      location:
          WeatherLocation.fromJson(json['location'] as Map<String, dynamic>),
      current: CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CurrentWeatherResponseImplToJson(
        _$CurrentWeatherResponseImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };
