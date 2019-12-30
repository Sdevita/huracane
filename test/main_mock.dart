import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:huracan/app.dart';
import 'package:huracan/network/api/dark_weather_api_client.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/network/repositories/weather_repository.dart';

import '../lib/bloc_delegate.dart';

void main() {
  final WeatherRepository weatherRepository = RepoDark(
    weatherApiClient: DarkWeatherApiClient(
      httpClient: MockClient((request) async {
        final file = new File('test_resources/weather.json');
        final res = json.decode(await file.readAsString());
        return Response(res, 200);
      }),
    ),
  );
  BlocSupervisor.delegate = HuracanBlocDelegate();
  runApp(App(
    weatherRepository: weatherRepository,
  ));
}
