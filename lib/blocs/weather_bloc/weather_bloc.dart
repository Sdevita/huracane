import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:huracan/blocs/weather_bloc/weather_event.dart';
import 'package:huracan/blocs/weather_bloc/weather_state.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/network/repositories/repositories.dart';
import 'package:huracan/network/responses/base_response.dart';
import 'package:huracan/network/responses/dark_weather_response.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final weatherResponse = await weatherRepository.getWeather(
            event.position, event.isoCountryCode);
        final weather = _createWeatherModel(weatherResponse);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
    if (event is RefreshWeather) {
      try {
        final weatherResponse = await weatherRepository.getWeather(
            event.position, event.isoCountryCode);
        final weather = _createWeatherModel(weatherResponse);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield state;
      }
    }
  }

  Weather _createWeatherModel(BaseResponse response) {
    final currentWeather =
        _createWeatherDataModel((response as DarkWeatherResponse)?.currently);
    final dailyForecast =
        _createDailyForecastModel((response as DarkWeatherResponse)?.daily);
    final hourlyForecast =
        _createHourlyForecastModel((response as DarkWeatherResponse)?.hourly);
    return Weather(
        current: currentWeather,
        dailyForecast: dailyForecast,
        hourlyForecast: hourlyForecast);
  }

  DailyForecast _createDailyForecastModel(Daily daily) {
    List<WeatherData> dailyReports = List();
    daily.data.forEach((obj) {
      dailyReports.add(_createWeatherDataModel(obj));
    });
    return DailyForecast(
        summary: daily.summary, icon: daily.icon, dailyForecast: dailyReports);
  }

  HourlyForecast _createHourlyForecastModel(Hourly hourlyList) {
    List<WeatherData> hourlyReports = List();
    hourlyList.data.forEach((obj) {
      hourlyReports.add(_createWeatherDataModel(obj));
    });
    return HourlyForecast(
        summary: hourlyList.summary,
        icon: hourlyList.icon,
        hourlyForecast: hourlyReports);
  }

  WeatherData _createWeatherDataModel(WeatherObj weatherObj) {
    return WeatherData(
        apparentTemperature: weatherObj?.apparentTemperature,
        cloudCover: weatherObj?.cloudCover,
        dewPoint: weatherObj?.dewPoint,
        humidity: weatherObj?.humidity,
        condition: _mapWeatherCondition(weatherObj?.icon),
        ozone: weatherObj?.ozone,
        precipIntensity: weatherObj?.precipIntensity,
        precipProbability: weatherObj?.precipIntensity,
        pressure: weatherObj?.precipIntensity,
        summary: weatherObj?.summary,
        temperature: weatherObj?.temperature,
        time: weatherObj?.time,
        uvIndex: weatherObj?.uvIndex,
        visibility: weatherObj?.uvIndex,
        windBearing: weatherObj?.windSpeed,
        windGust: weatherObj?.windGust,
        windSpeed: weatherObj?.windSpeed,
        maxTemperature: weatherObj?.temperatureMax,
        minTemperature: weatherObj?.temperatureMin);
  }

  WeatherCondition _mapWeatherCondition(String icon) {
    WeatherCondition condition;
    switch (icon) {
      case "clear-day":
        condition = WeatherCondition.clearDay;
        break;
      case "clear-night":
        condition = WeatherCondition.clearNight;
        break;
      case "rain":
        condition = WeatherCondition.rain;
        break;
      case "snow":
        condition = WeatherCondition.snow;
        break;
      case "sleet":
        condition = WeatherCondition.sleet;
        break;
      case "wind":
        condition = WeatherCondition.wind;
        break;
      case "fog":
        condition = WeatherCondition.fog;
        break;
      case "cloudy":
        condition = WeatherCondition.cloudy;
        break;
      case "partly-cloudy-day":
        condition = WeatherCondition.partlyCloudyDay;
        break;
      case "partly-cloudy-night":
        condition = WeatherCondition.partlyCloudyNight;
        break;
      default:
        condition = WeatherCondition.unknown;
    }
    return condition;
  }
}
