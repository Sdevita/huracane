import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  WeatherData current;

  Weather({this.current});

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class WeatherData extends Equatable {
  String time;
  String summary;
  String icon;
  double precipIntensity;
  double precipProbability;
  double temperature;
  double apparentTemperature;
  double dewPoint;
  double humidity;
  double pressure;
  double windSpeed;
  double windGust;
  double windBearing;
  double cloudCover;
  double uvIndex;
  double visibility;
  double ozone;

  @override
  // TODO: implement props
  List<Object> get props => [
        time,
        summary,
        icon,
        precipIntensity,
        precipProbability,
        temperature,
        apparentTemperature,
        dewPoint,
        humidity,
        pressure,
        windSpeed,
        windGust,
        windBearing,
        cloudCover,
        uvIndex,
        visibility,
        ozone
      ];
}
