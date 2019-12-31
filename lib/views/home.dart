import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:huracan/blocs/weather_bloc.dart';
import 'package:huracan/models/models.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LottieController controller;

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
          final summary = state.weather.current.summary;
          return Center(
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: LottieView.fromFile(
                      filePath: "resources/animations/day_storm_anim.json",
                      autoPlay: true,
                      loop: true,
                      onViewCreated: onViewCreatedFile)));
        }
        return Center(child: Text("Error"));
      }),
    );
  }

  void onViewCreatedFile(LottieController controller) {
    this.controller = controller;
    // Listen for when the playback completes
    this.controller.onPlayFinished.listen((bool animationFinished) {
      print("Playback complete. Was Animation Finished? " +
          animationFinished.toString());
    });
  }
}
