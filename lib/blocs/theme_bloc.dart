import 'dart:async';

import 'package:flutter/material.dart';
import 'package:huracan/models/models.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  const ThemeState({@required this.theme, @required this.color})
      : assert(theme != null),
        assert(color != null);

  @override
  List<Object> get props => [theme, color];
}

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  const WeatherChanged({@required this.condition}) : assert(condition != null);

  @override
  List<Object> get props => [condition];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
    theme: ThemeData(
      primaryColor: Colors.lightBlue[800]
    ),
    color: Colors.lightBlue,
  );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is WeatherChanged) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

  ThemeState _mapWeatherConditionToThemeData(WeatherCondition condition) {
    ThemeState theme;
    switch (condition) {
      case WeatherCondition.clearDay:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.amber[800],
          ),
          color: Colors.amber,
        );
        break;
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.grey[800],
          ),
          color: Colors.grey,
        );
        break;
      case WeatherCondition.fog:
      case WeatherCondition.cloudy:
      case WeatherCondition.wind:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.blueGrey[800],
          ),
          color: Colors.blueGrey
        );
        break;
      case WeatherCondition.partlyCloudyDay:
      case WeatherCondition.partlyCloudyNight:
      case WeatherCondition.clearNight:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.indigo[800],
          ),
          color: Colors.indigo,
        );
        break;
      case WeatherCondition.rain:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.deepPurple[800],
          ),
          color: Colors.deepPurple,
        );
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
        break;
    }
    return theme;
  }
}
