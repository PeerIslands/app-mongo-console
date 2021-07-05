import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/dashboard_repository.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class GetDashboardData implements UseCase<Dashboard, NoParams> {
  final MeasurementRepository measurementRepository;
  final DashboardRepository dashboardRepository;

  GetDashboardData(this.measurementRepository, this.dashboardRepository);

  @override
  Future<Either<Failure, Dashboard>> call(NoParams params) async {
    var groupOrFailure = await measurementRepository.getGroup();
    return groupOrFailure.fold(
      (failure) => Left(failure),
      (group) async =>
          await dashboardRepository.getDashboardData(groupId: group.id),
    );
  }
}
