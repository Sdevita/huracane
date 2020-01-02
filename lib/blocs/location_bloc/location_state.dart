import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState{}

class LocationError extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;
  final String place;
  final String isoCountryCode;

  const LocationLoaded({@required this.position, @required this.place, @required this.isoCountryCode});

  @override
  List<Object> get props => [position, place];
}
