import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/group.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';

abstract class MeasurementRepository {
  Future<Either<Failure, Measurement>> fetchMeasurements(
      List<BaseMeasurementQuery> params);

  Future<Either<Failure, Group>> getGroup();

  Future<Either<Failure, List<Process>>> getProcesses(String groupId);

  Future<Either<Failure, List<BaseMeasurementQuery>>> getParams(
      List<BaseMeasurementQuery> params);

  Future<void> saveParams(List<BaseMeasurementQuery> params);

  Future<void> clearParams();
}
