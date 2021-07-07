import 'package:equatable/equatable.dart';
import 'package:flutter_auth/core/widgets/line_chart_item.dart';
import 'package:flutter_auth/features/metric_charts/data/models/measurement_model.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';

class DashboardChart extends Equatable {
  final String title;
  final Measurement measurement;
  final bool justRefreshDataIfPinned;

  DashboardChart({this.measurement, this.title, this.justRefreshDataIfPinned = false});

  factory DashboardChart.fromJson(Map<String, dynamic> json) {
    return DashboardChart(
        title: json['title'],
        measurement: json['measurement'] != null
            ? MeasurementModel.fromJson(json['measurement'])
            : null);
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'measurement': this.measurement != null
            ? (this.measurement as MeasurementModel).toJson()
            : null,
      };

  @override
  List<Object> get props => [this.measurement];
}
