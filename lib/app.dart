import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/views/home.dart';
import 'blocs/blocs.dart';
import 'blocs/location_bloc/location_bloc.dart';
import 'blocs/theme_bloc/theme_state.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (BuildContext context) =>
                LocationBloc(),
            child: Home(),
          ));
    });
  }
}
