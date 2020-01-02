import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/app.dart';
import 'package:http/http.dart' as http;
import 'package:huracan/network/api/dark_weather_api_client.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/network/repositories/weather_repository.dart';
import 'package:bloc/bloc.dart';

import 'bloc_delegate.dart';
import 'blocs/blocs.dart';

void main() {
  final WeatherRepository weatherRepository = RepoDark(
    weatherApiClient: DarkWeatherApiClient(
      httpClient: http.Client(),
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
