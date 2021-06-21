import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/enums/measurement_type_enum.dart';

@immutable
abstract class MeasurementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClearParams extends MeasurementEvent {}

class ChangeParams extends MeasurementEvent {
  final Process process;
  final String granularity;
  final List<MeasurementType> types;
  final DateTime startDate;
  final DateTime endDate;
  final bool isBaseQuery;

  ChangeParams(
      {this.process,
      this.types,
      this.startDate,
      this.endDate,
      this.granularity,
      this.isBaseQuery = false});

  @override
  List<Object> get props => [process, startDate, endDate];
}

class GetConnectionData extends MeasurementEvent {
  final DateTime startDate;
  final DateTime endDate;
  final Process process;

  GetConnectionData(
      {@required this.startDate,
      @required this.endDate,
      @required this.process});

  @override
  List<Object> get props => [startDate, endDate, process];
}

class GetBytesInBytesOutData extends MeasurementEvent {
  final DateTime startDate;
  final DateTime endDate;
  final Process process;

  GetBytesInBytesOutData({@required this.startDate,
    @required this.endDate,
    @required this.process});

  @override
  List<Object> get props => [startDate, endDate, process];
}
