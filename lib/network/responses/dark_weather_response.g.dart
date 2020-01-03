// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dark_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DarkWeatherResponse _$DarkWeatherResponseFromJson(Map<String, dynamic> json) {
  return DarkWeatherResponse(
    Daily.fromJson(json['daily'] as Map<String, dynamic>),
    WeatherObj.fromJson(json['currently'] as Map<String, dynamic>),
  )..hourly = Hourly.fromJson(json['hourly'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DarkWeatherResponseToJson(
        DarkWeatherResponse instance) =>
    <String, dynamic>{
      'currently': instance.currently,
      'hourly': instance.hourly,
      'daily': instance.daily,
    };

WeatherObj _$WeatherObjFromJson(Map<String, dynamic> json) {
  return WeatherObj(
    time: json['time'] as int,
    summary: json['summary'] as String,
    icon: json['icon'] as String,
    precipIntensity: (json['precipIntensity'] as num)?.toDouble(),
    precipProbability: (json['precipProbability'] as num)?.toDouble(),
    temperature: (json['temperature'] as num)?.toDouble(),
    apparentTemperature: (json['apparentTemperature'] as num)?.toDouble(),
    dewPoint: (json['dewPoint'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    windSpeed: (json['windSpeed'] as num)?.toDouble(),
    windBearing: json['windBearing'] as int,
    cloudCover: (json['cloudCover'] as num)?.toDouble(),
    ozone: (json['ozone'] as num)?.toDouble(),
    uvIndex: (json['uvIndex'] as num)?.toDouble(),
    visibility: (json['visibility'] as num)?.toDouble(),
    windGust: (json['windGust'] as num)?.toDouble(),
  )
    ..temperatureMin = (json['temperatureMin'] as num)?.toDouble()
    ..temperatureMinTime = json['temperatureMinTime'] as int
    ..temperatureMax = (json['temperatureMax'] as num)?.toDouble()
    ..temperatureMaxTime = json['temperatureMaxTime'] as int
    ..apparentTemperatureMin =
        (json['apparentTemperatureMin'] as num)?.toDouble()
    ..apparentTemperatureMinTime = json['apparentTemperatureMinTime'] as int
    ..apparentTemperatureMax =
        (json['apparentTemperatureMax'] as num)?.toDouble()
    ..apparentTemperatureMaxTime = json['apparentTemperatureMaxTime'] as int;
}

Map<String, dynamic> _$WeatherObjToJson(WeatherObj instance) =>
    <String, dynamic>{
      'time': instance.time,
      'summary': instance.summary,
      'icon': instance.icon,
      'precipIntensity': instance.precipIntensity,
      'precipProbability': instance.precipProbability,
      'temperature': instance.temperature,
      'apparentTemperature': instance.apparentTemperature,
      'dewPoint': instance.dewPoint,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windGust': instance.windGust,
      'windBearing': instance.windBearing,
      'cloudCover': instance.cloudCover,
      'uvIndex': instance.uvIndex,
      'visibility': instance.visibility,
      'ozone': instance.ozone,
      'temperatureMin': instance.temperatureMin,
      'temperatureMinTime': instance.temperatureMinTime,
      'temperatureMax': instance.temperatureMax,
      'temperatureMaxTime': instance.temperatureMaxTime,
      'apparentTemperatureMin': instance.apparentTemperatureMin,
      'apparentTemperatureMinTime': instance.apparentTemperatureMinTime,
      'apparentTemperatureMax': instance.apparentTemperatureMax,
      'apparentTemperatureMaxTime': instance.apparentTemperatureMaxTime,
    };

Daily _$DailyFromJson(Map<String, dynamic> json) {
  return Daily(
    icon: json['icon'] as String,
    summary: json['summary'] as String,
    data: (json['data'] as List)
        .map((e) => WeatherObj.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'summary': instance.summary,
      'icon': instance.icon,
      'data': instance.data,
    };

Hourly _$HourlyFromJson(Map<String, dynamic> json) {
  return Hourly(
    icon: json['icon'] as String,
    summary: json['summary'] as String,
    data: (json['data'] as List)
        .map((e) => WeatherObj.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
      'summary': instance.summary,
      'icon': instance.icon,
      'data': instance.data,
    };
