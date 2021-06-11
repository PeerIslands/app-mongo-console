import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';

@immutable
abstract class MeasurementState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MeasurementState {}

class DataLoading extends MeasurementState {}

class DataLoaded extends MeasurementState {
  final Measurement measurement;

  DataLoaded({@required this.measurement});

  @override
  List<Object> get props => [measurement];
}

class DataFailed extends MeasurementState {
  final String message;

  DataFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class ParamsChanged extends MeasurementState {
  final List<BaseMeasurementQuery> params;

  ParamsChanged(this.params);

  @override
  List<Object> get props => [params];
}
