// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_weather_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentWeatherResponse _$CurrentWeatherResponseFromJson(
    Map<String, dynamic> json) {
  return _CurrentWeatherResponse.fromJson(json);
}

/// @nodoc
mixin _$CurrentWeatherResponse {
  WeatherLocation get location => throw _privateConstructorUsedError;
  CurrentWeather get current => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentWeatherResponseCopyWith<CurrentWeatherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentWeatherResponseCopyWith<$Res> {
  factory $CurrentWeatherResponseCopyWith(CurrentWeatherResponse value,
          $Res Function(CurrentWeatherResponse) then) =
      _$CurrentWeatherResponseCopyWithImpl<$Res, CurrentWeatherResponse>;
  @useResult
  $Res call({WeatherLocation location, CurrentWeather current});

  $WeatherLocationCopyWith<$Res> get location;
  $CurrentWeatherCopyWith<$Res> get current;
}

/// @nodoc
class _$CurrentWeatherResponseCopyWithImpl<$Res,
        $Val extends CurrentWeatherResponse>
    implements $CurrentWeatherResponseCopyWith<$Res> {
  _$CurrentWeatherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as WeatherLocation,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentWeather,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherLocationCopyWith<$Res> get location {
    return $WeatherLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentWeatherCopyWith<$Res> get current {
    return $CurrentWeatherCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CurrentWeatherResponseImplCopyWith<$Res>
    implements $CurrentWeatherResponseCopyWith<$Res> {
  factory _$$CurrentWeatherResponseImplCopyWith(
          _$CurrentWeatherResponseImpl value,
          $Res Function(_$CurrentWeatherResponseImpl) then) =
      __$$CurrentWeatherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WeatherLocation location, CurrentWeather current});

  @override
  $WeatherLocationCopyWith<$Res> get location;
  @override
  $CurrentWeatherCopyWith<$Res> get current;
}

/// @nodoc
class __$$CurrentWeatherResponseImplCopyWithImpl<$Res>
    extends _$CurrentWeatherResponseCopyWithImpl<$Res,
        _$CurrentWeatherResponseImpl>
    implements _$$CurrentWeatherResponseImplCopyWith<$Res> {
  __$$CurrentWeatherResponseImplCopyWithImpl(
      _$CurrentWeatherResponseImpl _value,
      $Res Function(_$CurrentWeatherResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? current = null,
  }) {
    return _then(_$CurrentWeatherResponseImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as WeatherLocation,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentWeather,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentWeatherResponseImpl extends _CurrentWeatherResponse {
  const _$CurrentWeatherResponseImpl(
      {required this.location, required this.current})
      : super._();

  factory _$CurrentWeatherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentWeatherResponseImplFromJson(json);

  @override
  final WeatherLocation location;
  @override
  final CurrentWeather current;

  @override
  String toString() {
    return 'CurrentWeatherResponse(location: $location, current: $current)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentWeatherResponseImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location, current);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentWeatherResponseImplCopyWith<_$CurrentWeatherResponseImpl>
      get copyWith => __$$CurrentWeatherResponseImplCopyWithImpl<
          _$CurrentWeatherResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentWeatherResponseImplToJson(
      this,
    );
  }
}

abstract class _CurrentWeatherResponse extends CurrentWeatherResponse {
  const factory _CurrentWeatherResponse(
      {required final WeatherLocation location,
      required final CurrentWeather current}) = _$CurrentWeatherResponseImpl;
  const _CurrentWeatherResponse._() : super._();

  factory _CurrentWeatherResponse.fromJson(Map<String, dynamic> json) =
      _$CurrentWeatherResponseImpl.fromJson;

  @override
  WeatherLocation get location;
  @override
  CurrentWeather get current;
  @override
  @JsonKey(ignore: true)
  _$$CurrentWeatherResponseImplCopyWith<_$CurrentWeatherResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
