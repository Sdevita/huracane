import 'package:huracan/models/models.dart';
import 'package:huracan/network/responses/base_response.dart';

abstract class WeatherRepository{
    Future<BaseResponse> getWeather(LatLng location);
}