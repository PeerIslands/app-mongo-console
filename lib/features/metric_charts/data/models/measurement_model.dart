import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/data/models/shared/links_model.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';

class MeasurementModel extends Measurement {
  MeasurementModel({@required end,
    @required granularity,
    @required groupId,
    @required hostId,
    @required links,
    @required measurements,
    @required processId,
    @required start})
      : super(
      end,
      granularity,
      groupId,
      hostId,
      links,
      measurements,
      processId,
      start);

  factory MeasurementModel.fromJson(Map<String, dynamic> json) => MeasurementModel(
        end: json['end'],
        granularity: json['granularity'],
        groupId: json['groupId'],
        hostId: json['hostId'],
        links: json['links'] != null
            ? json['links'].forEach((v) {
          new LinksModel.fromJson(v);
        })
            : [],
        measurements: json['measurements'] != null
            ? json['measurements'].forEach((v) {
          new MeasurementsModel.fromJson(v);
        })
            : [],
        processId: json['processId'],
        start: json['start']);

  Map<String, dynamic> toJson() => {
      'end': end,
      'granularity': granularity,
      'groupId': groupId,
      'hostId': hostId,
      'processId': processId,
      'start': start,
      'links': this.links != null ? (links as List<LinksModel>).map((v) => v.toJson()).toList() : [],
      'measurements': this.measurements != null ? (measurements as List<MeasurementsModel>).map((v) => v.toJson()).toList() : [],
    };
}

class MeasurementsModel extends Measurements {
  MeasurementsModel({@required dataPoints, @required name, @required units})
      : super(dataPoints, name, units);

  factory MeasurementsModel.fromJson(Map<String, dynamic> json) => MeasurementsModel(
        dataPoints: json['dataPoints'] != null ?
        json['dataPoints'].forEach((v) {
          new DataPointsModel.fromJson(v);
        }) : [],
        name: json['name'],
        units: json['units']);

  Map<String, dynamic> toJson() => {
      'name': name,
      'units': units,
      'dataPoints': this.dataPoints != null ? (dataPoints as List<DataPointsModel>).map((v) => v.toJson()).toList() : [],
    };
}

class DataPointsModel extends DataPoints {
  DataPointsModel({@required timestamp, @required value}) : super(timestamp, value);

  factory DataPointsModel.fromJson(Map<String, dynamic> json) => DataPointsModel(timestamp: json['timestamp'], value: json['value']);

  Map<String, dynamic> toJson() => {
      'timestamp': timestamp,
      'value': value
    };
}
