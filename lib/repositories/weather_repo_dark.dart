import 'package:flutter/cupertino.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/models/weather.dart';
import 'package:huracan/repositories/dark_weather_api_client.dart';
import 'package:huracan/repositories/weather_repository.dart';

class RepoDark implements WeatherRepository{
  final DarkWeatherApiClient weatherApiClient;

  RepoDark({@required this.weatherApiClient});

  @override
  Future<Weather> getWeather(LatLng location) async{
    return await weatherApiClient.forecastRequest(location);
  }
}