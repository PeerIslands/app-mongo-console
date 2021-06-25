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

class BaseQueryBuilt extends MeasurementState {}

class MeasurementDataLoading extends MeasurementState {}

class ParamsChanged extends MeasurementState {
  final List<BaseMeasurementQuery> params;

  ParamsChanged(this.params);

  @override
  List<Object> get props => [params];
}

class MeasurementDataLoaded extends MeasurementState {
  final Measurement measurement;

  MeasurementDataLoaded({@required this.measurement});

  @override
  List<Object> get props => [measurement];
}

class MeasurementDataFailed extends MeasurementState {
  final String message;

  MeasurementDataFailed({@required this.message});

  @override
  List<Object> get props => [message];
}
