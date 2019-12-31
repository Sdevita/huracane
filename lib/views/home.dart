import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/blocs/weather_bloc.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/views/custom_widget/custom_widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context)
        .add(FetchWeather(position: LatLng(latitude: 39.18, longitude: 16.15)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Huracàn'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is WeatherLoaded) {
          final condition = state.weather.current.condition;
          final temperature = state.weather.current.temperature;
          return Column(
            children: <Widget>[
              Center(
                  child: WeatherIcon(width: 200,height: 200,weatherCondition: condition,)),
              Text("Temperatura: $temperature")
            ],
          );
        }
        return Center(child: Text("Error"));
      }),
    );
  }
}
