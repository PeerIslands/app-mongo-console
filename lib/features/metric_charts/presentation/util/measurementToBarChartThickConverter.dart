import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:intl/intl.dart';

class BarChartThickItem {
  final int index;
  final String dayOfWeek;
  final int value;


  BarChartThickItem({this.index, this.dayOfWeek, this.value});
}

class MeasurementToBarChartThickConverter {
  List<BarChartThickItem> convert(Measurement measurement) {
    List<BarChartThickItem> items = [];
    measurement.measurements.forEach((measurementItem) {
      measurementItem.dataPoints.asMap().forEach((index, dataPoint) {
        BarChartThickItem barChartThickItem = BarChartThickItem(
            dayOfWeek: DateFormat('EEEE').format(DateTime.parse(dataPoint.timestamp)),
            index: index);

        items.add(barChartThickItem);
      });
    });

    return items;
  }
}