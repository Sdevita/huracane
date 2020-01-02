import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:huracan/models/models.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final LatLng position;
  final String isoCountryCode;
  const FetchWeather({@required this.position, @required this.isoCountryCode}) : assert(position != null);

  @override
  List<Object> get props => [position];
}

class RefreshWeather extends WeatherEvent {
  final LatLng position;
  final String isoCountryCode;

  const RefreshWeather({@required this.position, @required this.isoCountryCode}) : assert(position != null);

  @override
  List<Object> get props => [position];
}
