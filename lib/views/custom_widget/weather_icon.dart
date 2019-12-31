import 'package:flutter/cupertino.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'package:huracan/models/models.dart';

class WeatherIcon extends StatelessWidget {
  double _height;
  double _width;
  WeatherCondition _condition;
  LottieController _lottieController;

  WeatherIcon(
      {@required double height,
      @required double width,
      @required WeatherCondition weatherCondition}) {
    this._height = height;
    this._width = width;
    this._condition = weatherCondition;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _width,
        height: _height,
        child: LottieView.fromFile(
            filePath: _getIconUrlFromWeatherCondition(),
            autoPlay: true,
            loop: true,
            onViewCreated: onViewCreatedFile));
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
    switch(_condition){
      case WeatherCondition.clearDay: url = "resources/animations/sunny_anim.json"; break;
      case WeatherCondition.clearNight: url = "resources/animations/night.json"; break;
      case WeatherCondition.rain: url = "resources/animations/storm.json"; break;
      case WeatherCondition.snow: url = "resources/animations/snow.json"; break;
      case WeatherCondition.sleet: url = "resources/animations/snow_sunny.json"; break;
      case WeatherCondition.fog: url = "resources/animations/mist.json"; break;
      case WeatherCondition.wind:
      case WeatherCondition.cloudy: url = "resources/animations/windy.json"; break;
      case WeatherCondition.partlyCloudyDay: url = "resources/animations/partly_cloudy.json"; break;
      case WeatherCondition.partlyCloudyNight: url = "resources/animations/cloudy_night.json"; break;
      default: url = "resources/animations/generic_error.json"; break;
    }
    return url;
  }
}
