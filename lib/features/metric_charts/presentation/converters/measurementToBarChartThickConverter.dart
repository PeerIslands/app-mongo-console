import 'package:flutter_auth/core/entities/bar_chart_thick_item.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:intl/intl.dart';

class MeasurementToBarChartThickConverter {
  List<BarChartThickItem> convert(Measurement measurement) {
    List<BarChartThickItem> items = [];
    measurement.measurements.forEach((measurementItem) {
      measurementItem.dataPoints.toList().asMap().forEach((index, dataPoint) {
        BarChartThickItem barChartThickItem = BarChartThickItem(
            dayOfWeek:
                DateFormat('EEEE').format(DateTime.parse(dataPoint.timestamp)),
            index: index,
            value: dataPoint.value);

        items.add(barChartThickItem);
      });
    });

    return items;
  }
}
