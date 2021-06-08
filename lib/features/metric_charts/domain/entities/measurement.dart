import 'package:equatable/equatable.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/share/links.dart';

class Measurement extends Equatable {
  final String end;
  final String granularity;
  final String groupId;
  final String hostId;
  final List<Links> links;
  final List<Measurements> measurements;
  final String processId;
  final String start;

  Measurement(this.end, this.granularity, this.groupId, this.hostId, this.links, this.measurements, this.processId, this.start);

  @override
  List<Object> get props => [end, granularity, groupId, hostId, links, measurements, processId, start];
}

class Measurements extends Equatable {
  final List<DataPoints> dataPoints;
  final String name;
  final String units;

  Measurements(this.dataPoints, this.name, this.units);

  @override
  List<Object> get props => [dataPoints, name, units];
}

class DataPoints extends Equatable {
  final String timestamp;
  final double value;

  DataPoints(this.timestamp, this.value);

  @override
  List<Object> get props => [timestamp, value];
}