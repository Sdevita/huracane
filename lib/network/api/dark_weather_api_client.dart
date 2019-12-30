import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:huracan/models/models.dart';
import 'package:huracan/network/responses/responses.dart';

class DarkWeatherApiClient{
  static const baseUrl = 'https://api.darksky.net';
  static const apiKey = '0361cbaa3b6e1ce67ea5d4e610864cb3';
  final http.Client httpClient;

  DarkWeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<DarkWeatherResponse> forecastRequest(LatLng location) async {
    final latitude = location.latitude;
    final longitude = location.longitude;
    final weatherUrl = '$baseUrl/forecast/$apiKey/$latitude,$longitude?units=auto';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if(weatherResponse.statusCode != 200) {
      throw Exception ('request error');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return DarkWeatherResponse.fromJson(weatherJson);
  }
}