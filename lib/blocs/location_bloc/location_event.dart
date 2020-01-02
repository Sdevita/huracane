import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable{
  const LocationEvent();
}

class FetchLocation extends LocationEvent {

  const FetchLocation();

  @override
  List<Object> get props => [];
}