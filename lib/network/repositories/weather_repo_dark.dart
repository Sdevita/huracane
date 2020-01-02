import 'package:flutter/cupertino.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/network/api/dark_weather_api_client.dart';
import 'package:huracan/network/repositories/weather_repository.dart';
import 'package:huracan/network/responses/base_response.dart';

class RepoDark implements WeatherRepository{
  final DarkWeatherApiClient weatherApiClient;

  RepoDark({@required this.weatherApiClient});

  @override
  Future<BaseResponse> getWeather(LatLng location, String isoCountryCode) async{
    return await weatherApiClient.forecastRequest(location, isoCountryCode);
  }
}