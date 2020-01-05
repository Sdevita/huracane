import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:huracan/models/models.dart';

class WeatherIcon extends StatelessWidget {
  double _height;
  double _width;
  bool _isAnimated;
  WeatherCondition _condition;
  LottieController _lottieController;

  WeatherIcon(
      {double height,
      double width,
      @required WeatherCondition weatherCondition,
      @required bool isAnimated}) {
    this._height = height;
    this._width = width;
    this._condition = weatherCondition;
    this._isAnimated = isAnimated;
  }

  @override
  Widget build(BuildContext context) {
    return _isAnimated
        ? SizedBox(
            width: _width,
            height: _height,
            child: LottieView.fromFile(
                filePath: _getIconUrlFromWeatherCondition(),
                autoPlay: true,
                loop: true,
                onViewCreated: onViewCreatedFile))
        : Image(
            image: AssetImage(_getIconUrlFromWeatherCondition()),
          );
  }

  void onViewCreatedFile(LottieController controller) {
    this._lottieController = controller;
    // Listen for when the playback completes
    this._lottieController.onPlayFinished.listen((bool animationFinished) {
      print("Playback complete. Was Animation Finished? " +
          animationFinished.toString());
    });
  }

  String _getIconUrlFromWeatherCondition() {
    var url;
    switch (_condition) {
      case WeatherCondition.clearDay:
        url = _isAnimated ? "resources/animations/sunny_anim.json": "resources/icons/sun_icon.png";
        break;
      case WeatherCondition.clearNight:
        url = _isAnimated ? "resources/animations/night.json" : "resources/icons/clear_night.png";
        break;
      case WeatherCondition.rain:
        url = _isAnimated ? "resources/animations/storm.json": "resources/icons/rain.png";
        break;
      case WeatherCondition.snow:
        url = _isAnimated ? "resources/animations/snow.json": "resources/icons/snow.png";
        break;
      case WeatherCondition.sleet:
        url = _isAnimated ? "resources/animations/snow_sunny.json": "resources/icons/sun_icon.png";
        break;
      case WeatherCondition.fog:
        url = _isAnimated ? "resources/animations/mist.json": "resources/icons/fog.png";
        break;
      case WeatherCondition.wind:
      case WeatherCondition.cloudy:
        url = _isAnimated ? "resources/animations/windy.json": "resources/icons/cloudy.png";
        break;
      case WeatherCondition.partlyCloudyDay:
        url = _isAnimated ? "resources/animations/partly_cloudy.json": "resources/icons/partly_clody_day.png";
        break;
      case WeatherCondition.partlyCloudyNight:
        url = _isAnimated ? "resources/animations/cloudy_night.json": "resources/icons/partly_clody_night.png";
        break;
      default:
        url = _isAnimated? "resources/animations/generic_error.json": "resources/icons/sun_icon.png";
        break;
    }
    return url;
  }
}
