import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  WeatherData current;
  HourlyForecast hourlyForecast;
  DailyForecast dailyForecast;

  Weather({this.current, this.dailyForecast, this.hourlyForecast});

  @override
  List<Object> get props => [current];
}

enum WeatherCondition {
  snow,
  rain,
  sleet,
  wind,
  fog,
  cloudy,
  clearDay,
  clearNight,
  partlyCloudyDay,
  partlyCloudyNight,
  unknown,
}

class WeatherData extends Equatable {
  int time;
  String summary;
  WeatherCondition condition;
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
  double maxTemperature;
  double minTemperature;

  WeatherData(
      {this.summary,
      this.condition,
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
      this.time,
      this.maxTemperature,
      this.minTemperature});

  @override
  List<Object> get props => [
        time,
        summary,
        condition,
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
        ozone,
        maxTemperature,
        minTemperature
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

class HourlyForecast extends Equatable {
  String summary;
  String icon;
  List<WeatherData> hourlyForecast;

  HourlyForecast({this.summary, this.icon, this.hourlyForecast});

  @override
  List<Object> get props => [summary, icon, hourlyForecast];
}
