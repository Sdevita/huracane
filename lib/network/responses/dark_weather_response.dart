import 'package:json_annotation/json_annotation.dart';
import 'base_response.dart';

part 'dark_weather_response.g.dart';


@JsonSerializable(nullable: false)
class DarkWeatherResponse extends BaseResponse {
  WeatherObj currently;
  Daily daily;

  DarkWeatherResponse(this.daily, this.currently);

  factory DarkWeatherResponse.fromJson(Map<String, dynamic> json) => _$DarkWeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DarkWeatherResponseToJson(this);
}

@JsonSerializable(nullable: false)
class WeatherObj {
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
  int windBearing;
  double cloudCover;
  double uvIndex;
  double visibility;
  double ozone;
  @JsonKey(nullable: true)
  double temperatureMin;
  @JsonKey(nullable: true)
  int temperatureMinTime;
  @JsonKey(nullable: true)
  double temperatureMax;
  @JsonKey(nullable: true)
  int temperatureMaxTime;
  @JsonKey(nullable: true)
  double apparentTemperatureMin;
  @JsonKey(nullable: true)
  int apparentTemperatureMinTime;
  @JsonKey(nullable: true)
  double apparentTemperatureMax;
  @JsonKey(nullable: true)
  int apparentTemperatureMaxTime;

  WeatherObj(
      {this.time,
      this.summary,
      this.icon,
      this.precipIntensity,
      this.precipProbability,
      this.temperature,
      this.apparentTemperature,
      this.dewPoint,
      this.humidity,
      this.pressure,
      this.windSpeed,
      this.windBearing,
      this.cloudCover,
      this.ozone,
      this.uvIndex,
      this.visibility,
      this.windGust});

  factory WeatherObj.fromJson(Map<String, dynamic> json) => _$WeatherObjFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherObjToJson(this);
}

@JsonSerializable(nullable: false)
class Daily {
  String summary;
  String icon;
  List<WeatherObj> data;

  Daily({this.icon, this.summary, this.data});
  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
