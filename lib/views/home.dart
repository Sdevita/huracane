import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/blocs/blocs.dart';
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
            BlocProvider.of<ThemeBloc>(context).add(
              WeatherChanged(condition: state.weather.current.condition),
            );
            final condition = state?.weather?.current?.condition;
            final temperature = state?.weather?.current?.temperature;
            final summary = state?.weather?.current?.summary;
            return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
              return GradientContainer(
                color: themeState.color,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontFamily: 'Montserrat'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "$summary",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'Montserrat'),
                        )),
                    SizedBox(
                      width: 100,
                      height: 30,
                    ),
                    Center(
                        child: WeatherIcon(
                      width: _getWeatherIconWidth(
                          MediaQuery.of(context).size.width),
                      height: MediaQuery.of(context).size.height / 4,
                      weatherCondition: condition,
                    )),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "$temperature °C",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'Montserrat'),
                        )),
                  ],
                ),
              );
            });
          }
          return Center(child: Text("Error"));
        }));
  }

  double _getWeatherIconWidth(double width) {
    // have to check ios platform, because the weather animation container may stretch in width
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS ? width / 2 : width;
  }
}
