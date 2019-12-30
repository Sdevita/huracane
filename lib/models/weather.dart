import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  WeatherData current;
  DailyForecast dailyForecast;

  Weather({this.current, this.dailyForecast});

  @override
  List<Object> get props => [current];
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

  WeatherData(
      {this.summary,
      this.icon,
      this.windGust,
      this.visibility,
      this.uvIndex,
      this.ozone,
      this.cloudCover,
      this.windBearing,
      this.windSpeed,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.apparentTemperature,
      this.temperature,
      this.precipProbability,
      this.precipIntensity,
      this.time});

  @override
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

class DailyForecast extends Equatable {
  String summary;
  String icon;
  List<WeatherData> dailyForecast;

  DailyForecast({this.summary, this.icon, this.dailyForecast});

  @override
  List<Object> get props => [summary, icon, dailyForecast];
}
