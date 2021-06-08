import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class FetchProcessData implements UseCase<List<Process>, NoParams> {
  final MeasurementRepository repository;

  FetchProcessData(this.repository);

  @override
  Future<Either<Failure, List<Process>>> call(NoParams params) async {
    var groupOrFailure = await repository.getGroup();
    return groupOrFailure.fold(
          (failure) => Left(failure),
          (group) async => await repository.getProcesses(group.id),
    );
  }
}