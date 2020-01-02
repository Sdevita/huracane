import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:huracan/app.dart';
import 'package:huracan/blocs/blocs.dart';
import 'package:huracan/network/api/dark_weather_api_client.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/network/repositories/weather_repository.dart';

import '../lib/bloc_delegate.dart';

void main() {
  final WeatherRepository weatherRepository = RepoDark(
    weatherApiClient: DarkWeatherApiClient(
      httpClient: MockClient((request) async {
        final res = await rootBundle.loadString('test_resources/weather.json');
        return Response(res, 200);
      }),
    ),
  );
  BlocSupervisor.delegate = HuracanBlocDelegate();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
    ),
    BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(weatherRepository: weatherRepository),
    )
  ], child: App()));
}
