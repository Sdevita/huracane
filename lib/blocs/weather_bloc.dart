import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:huracan/models/lat_lng.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/repositories/repositories.dart';

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
        final Weather weather = await weatherRepository.getWeather(event.position);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
    if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.position);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }
}