import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/views/home.dart';
import 'blocs/blocs.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (BuildContext context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: Home(),
          ));
    });
  }
}
