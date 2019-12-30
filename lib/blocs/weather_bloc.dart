import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:huracan/models/lat_lng.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/network/responses/base_response.dart';
import 'package:huracan/network/responses/dark_weather_response.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final LatLng position;

  const FetchWeather({@required this.position}) : assert(position != null);

  @override
  List<Object> get props => [position];
}

class RefreshWeather extends WeatherEvent {
  final LatLng position;

  const RefreshWeather({@required this.position}) : assert(position != null);

  @override
  List<Object> get props => [position];
}

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weatherResponse =
            await weatherRepository.getWeather(event.position);
        final weather = _createWeatherModel(weatherResponse);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
    if (event is RefreshWeather) {
      try {
        final weatherResponse =
            await weatherRepository.getWeather(event.position);
        final weather = _createWeatherModel(weatherResponse);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }

  Weather _createWeatherModel(BaseResponse response) {
    final currentWeather = _createWeatherDataModel((response as DarkWeatherResponse)?.currently);
    return Weather(current: currentWeather,);
  }

  DailyForecast _createDailyForecastModel(Daily daily){
    List<WeatherData> dailyReports = List();
    daily.data.forEach((obj){
      dailyReports.add(_createWeatherDataModel(obj));
    });
    return DailyForecast(summary: daily.summary, icon: daily.icon, dailyForecast: dailyReports);
}

  WeatherData _createWeatherDataModel(WeatherObj weatherObj){
    return WeatherData(
        apparentTemperature: weatherObj?.apparentTemperature,
        cloudCover: weatherObj?.cloudCover,
        dewPoint: weatherObj?.dewPoint,
        humidity: weatherObj?.humidity,
        icon: weatherObj?.icon,
        ozone: weatherObj?.ozone,
        precipIntensity: weatherObj?.precipIntensity,
        precipProbability: weatherObj?.precipIntensity,
        pressure: weatherObj?.precipIntensity,
        summary: weatherObj?.summary,
        temperature: weatherObj?.temperature,
        time: weatherObj?.time,
        uvIndex: weatherObj?.uvIndex,
        visibility: weatherObj?.uvIndex,
        windBearing: weatherObj?.windSpeed,
        windGust: weatherObj?.windGust,
        windSpeed: weatherObj?.windSpeed);
  }
}
