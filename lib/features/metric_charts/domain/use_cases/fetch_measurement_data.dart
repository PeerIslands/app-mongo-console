import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';
import 'package:flutter_auth/features/metric_charts/domain/util/measurement_queries.dart';

class FetchMeasurementData implements UseCase<Measurement, Params> {
  final MeasurementRepository repository;

  FetchMeasurementData(this.repository);

  @override
  Future<Either<Failure, Measurement>> call(Params params) async {
    return await repository.fetchMeasurements(params.params);
  }
}

class Params extends Equatable {
  final List<BaseMeasurementQuery> params;

  Params({@required this.params});

  @override
  List<Object> get props => [params];
}
