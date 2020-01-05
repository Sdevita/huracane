import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huracan/blocs/blocs.dart';
import 'package:huracan/blocs/location_bloc/location_bloc.dart';
import 'package:huracan/blocs/location_bloc/location_event.dart';
import 'package:huracan/blocs/location_bloc/location_state.dart';
import 'package:huracan/blocs/theme_bloc/theme_event.dart';
import 'package:huracan/blocs/theme_bloc/theme_state.dart';
import 'package:huracan/blocs/weather_bloc/weather_bloc.dart';
import 'package:huracan/blocs/weather_bloc/weather_event.dart';
import 'package:huracan/blocs/weather_bloc/weather_state.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/utils/chart_utils.dart';
import 'package:huracan/utils/date_utils.dart';
import 'package:huracan/views/custom_widget/custom_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'custom_widget/temperature_chart.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(FetchLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          color: Colors.transparent,
          renderPanelSheet: false,
          backdropEnabled: true,
          minHeight: MediaQuery.of(context).size.height * 0.6,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          parallaxEnabled: true,
          parallaxOffset: 0.2,
          panel: Stack(
            children: <Widget>[
              _getWave(),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  Flexible(flex: 2, child: _buildText("Oggi")),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(flex: 3, child: _buildTodayList()),
                  Flexible(flex: 2, child: _buildText("Settimana")),
                  Flexible(flex: 3, child: _buildWeekList()),
                ],
              ),
            ],
          ),
          body: _buildBody()),
    );
  }

  double _getWeatherIconWidth(double width) {
    // have to check ios platform, because the weather animation container may stretch in width
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return isIOS ? width / 2 : width;
  }

  Widget _buildBody() {
    return BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
      if (locationState is LocationLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (locationState is LocationError) {}
      if (locationState is LocationLoaded) {
        final position = locationState.position;
        final place = locationState?.place;
        return BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
          if (state is WeatherEmpty) {
            BlocProvider.of<WeatherBloc>(context).add(
              FetchWeather(
                  position: LatLng(
                      longitude: position.longitude,
                      latitude: position.latitude),
                  isoCountryCode: "it"),
            ); //todo Add internazionalization support //Localizations.localeOf(context).languageCode));
            return Center(child: CircularProgressIndicator());
          }
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
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.1,
                                  left: 20),
                              child: Text(
                                place,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 10, left: 20),
                              child: Text(
                                "$summary",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "$temperature °C",
                                style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: WeatherIcon(
                                width: _getWeatherIconWidth(
                                    MediaQuery.of(context).size.width),
                                height: MediaQuery.of(context).size.height / 4,
                                weatherCondition: condition,
                                isAnimated: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            });
          }
          return Center(child: Text("Error"));
        });
      }
      return Center(child: Text("Error"));
    });
  }

  Widget _getWave() {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return WaveWidget(
          config: CustomConfig(
              gradients: [
                [themeState.color[800], themeState.color[800]],
                [themeState.color[600], themeState.color[600]],
                [themeState.color[500], themeState.color[500]],
                [themeState.color[400], themeState.color[400]],
              ],
              durations: [
                35000,
                19440,
                10800,
                6000
              ],
              heightPercentages: [
                0.20,
                0.23,
                0.25,
                0.30
              ],
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight),
          waveAmplitude: 0,
          backgroundColor: Colors.transparent,
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height));
    });
  }

  Widget _buildTodayList() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoaded) {
        final hourlyList = state.weather?.hourlyForecast?.hourlyForecast;
        const upperBound = 8;
        return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyList.length > upperBound
                  ? upperBound
                  : hourlyList.length,
              itemBuilder: (context, index) {
                final date = new DateTime.fromMillisecondsSinceEpoch(
                    hourlyList[index].time * 1000);
                final temperature =
                    hourlyList[index]?.temperature?.toStringAsFixed(0);
                return Card(
                  elevation: 0,
                  color: themeState.color[600],
                  child: (index == hourlyList.length - 1 ||
                          index == upperBound - 1)
                      ? _buildShowMoreCard()
                      : _buildHourlyCard(
                          temperature, hourlyList[index]?.condition, date),
                );
              });
        });
      }
      return Center(child: CircularProgressIndicator());
    });
  }

  Widget _buildWeekList() {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoaded) {
        final dailyList = state.weather?.dailyForecast?.dailyForecast;
        const upperBound = 8;
        return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  dailyList.length > upperBound ? upperBound : dailyList.length,
              itemBuilder: (context, index) {
                final maxTemperature = dailyList[index]?.maxTemperature?.round();
                final minTemperature = dailyList[index]?.maxTemperature?.round();
                return Card(
                  elevation: 0,
                  color: themeState.color[600],
                  child:
                      (index == dailyList.length - 1 || index == upperBound - 1)
                          ? _buildShowMoreCard()
                          : _buildWeeklyCard(
                              minTemperature.toString(),
                              maxTemperature.toString(),
                              dailyList[index]?.condition,
                              DateUtils.getDayFromMillis(dailyList[index].time)
                                  .toString()),
                );
              });
        });
      }
      return Center(child: CircularProgressIndicator());
    });
  }

  Widget _buildShowMoreCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Flexible(
              flex: 4,
              child: Text(
                "More",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          Flexible(
            flex: 5,
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHourlyCard(
      String temperature, WeatherCondition condition, DateTime date) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                date.hour.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              )),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: WeatherIcon(
                isAnimated: false,
                weatherCondition: condition,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$temperature °C",
              style: TextStyle(
                  fontSize: 16, color: Colors.white, fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCard(
      String min, String max, WeatherCondition condition, String day) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                day,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              )),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: WeatherIcon(
                isAnimated: false,
                weatherCondition: condition,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$max °C",
              style: TextStyle(
                  fontSize: 12, color: Colors.white, fontFamily: 'Montserrat'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "$min °C",
              style: TextStyle(
                  fontSize: 12, color: Colors.white, fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
      ),
    );
  }
}
