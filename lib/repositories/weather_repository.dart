import 'package:huracan/models/models.dart';

abstract class WeatherRepository{
    Future<Weather> getWeather(LatLng location);
}