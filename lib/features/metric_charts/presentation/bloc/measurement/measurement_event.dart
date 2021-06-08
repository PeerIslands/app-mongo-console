import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/constants/measurement_query_constants.dart';

@immutable
abstract class MeasurementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataRequested extends MeasurementEvent {
  final List<BaseMeasurementQuery> params;

  FetchDataRequested(this.params);

  @override
  List<Object> get props => [params];
}
