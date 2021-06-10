import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';

@immutable
abstract class MeasurementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProcessChanged extends MeasurementEvent {
  final Process process;

  ProcessChanged({@required this.process});

  @override
  List<Object> get props => [process];
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
