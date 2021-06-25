import 'package:flutter_auth/core/entities/line_chart_thick_item.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:intl/intl.dart';

class MeasurementToLineChartItemConverter {
  List<List<LineChartThickItem>> convert(Measurement measurement) {
    List<List<LineChartThickItem>> arrayOfLines = [];
    measurement.measurements.forEach((measurementItem) {
      List<LineChartThickItem> items = [];
      if (measurementItem.dataPoints.isNotEmpty) {
        measurementItem.dataPoints.toList().asMap().forEach((index, dataPoint) {
          LineChartThickItem barChartThickItem = LineChartThickItem(
              text: measurementItem.name,
              dayOfWeek: DateFormat('EEEE')
                  .format(DateTime.parse(dataPoint.timestamp)),
              index: index,
              value: dataPoint.value ?? 0);

          items.add(barChartThickItem);
        });
      }

      if (items.isNotEmpty) {
        arrayOfLines.add(items);
      }
    });

    return arrayOfLines;
  }
}
