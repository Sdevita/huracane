import 'package:charts_flutter/flutter.dart';
import 'package:huracan/models/models.dart';
import 'package:huracan/utils/date_utils.dart';
import 'package:huracan/views/custom_widget/temperature_chart.dart';

class ChartUtils {
  static List<Series<LinearTemperature, int>> createHomeTemperatureData(
      Weather weather) {
    final hourlyData = weather?.dailyForecast?.dailyForecast;
    List<LinearTemperature> linearTemperature = List();
    for (int i = 0; i < hourlyData.length; i++) {
      linearTemperature.add(LinearTemperature(
          DateUtils.getDayFromMillis(hourlyData[i]?.time),
          hourlyData[i]?.windSpeed?.round()));
    }
    return [
      new Series<LinearTemperature, int>(
        id: 'HourlyTemperature',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) =>
            temperature.temperature,
        data: linearTemperature,
      )
        // Configure our custom bar target renderer for this series.
        ..setAttribute(rendererIdKey, 'temperature')
    ];
  }
}
