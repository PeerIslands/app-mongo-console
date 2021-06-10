import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/group.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/util/measurement_queries.dart';

abstract class MeasurementRepository {
  Future<Either<Failure, Measurement>> fetchMeasurements(
      List<BaseMeasurementQuery> params);

  Future<Either<Failure, Group>> getGroup();

  Future<Either<Failure, List<Process>>> getProcesses(String groupId);
}
