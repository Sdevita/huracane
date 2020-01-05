import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AreaAndLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  AreaAndLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data
  factory AreaAndLineChart.withSampleData() {
    return new AreaAndLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory AreaAndLineChart.withRandomData() {
    return new AreaAndLineChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<LinearTemperature, num>> _createRandomData() {
    final random = new Random();

    final myFakeDesktopData = [
      new LinearTemperature(0, random.nextInt(100)),
      new LinearTemperature(1, random.nextInt(100)),
      new LinearTemperature(2, random.nextInt(100)),
      new LinearTemperature(3, random.nextInt(100)),
    ];

    var myFakeTabletData = [
      new LinearTemperature(0, random.nextInt(100)),
      new LinearTemperature(1, random.nextInt(100)),
      new LinearTemperature(2, random.nextInt(100)),
      new LinearTemperature(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearTemperature, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) => temperature.temperature,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearTemperature, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) => temperature.temperature,
        data: myFakeTabletData,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'temperature'),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animationDuration: Duration(seconds: 3),
        animate: animate,
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'temperature',
              includeArea: true,
              stacked: true),
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearTemperature, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearTemperature(0, 5),
      new LinearTemperature(1, 25),
      new LinearTemperature(2, 100),
      new LinearTemperature(3, 75),
    ];

    var myFakeTabletData = [
      new LinearTemperature(0, 10),
      new LinearTemperature(1, 50),
      new LinearTemperature(2, 200),
      new LinearTemperature(3, 150),
    ];

    return [
      new charts.Series<LinearTemperature, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) => temperature.temperature,
        data: myFakeDesktopData,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'temperature'),
      new charts.Series<LinearTemperature, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearTemperature temperature, _) => temperature.hour,
        measureFn: (LinearTemperature temperature, _) => temperature.temperature,
        data: myFakeTabletData,
      ),
    ];
  }
}

/// Sample linear data type.
class LinearTemperature {
  final int hour;
  final int temperature;

  LinearTemperature(this.hour, this.temperature);
}