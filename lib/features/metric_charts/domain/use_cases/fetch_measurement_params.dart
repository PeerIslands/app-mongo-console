import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class FetchMeasurementParams
    implements UseCase<List<BaseMeasurementQuery>, List<BaseMeasurementQuery>> {
  final MeasurementRepository repository;

  FetchMeasurementParams(this.repository);

  @override
  Future<Either<Failure, List<BaseMeasurementQuery>>> call(
      List<BaseMeasurementQuery> params) async {
    var paramsToBeUpdatedOrFailure = await repository.getParams(params);

    return paramsToBeUpdatedOrFailure.fold((failure) async {
      await repository.saveParams(params);

      return Right(params);
    }, (existingParameters) async {
      params.forEach((paramToBeUpdated) {
        existingParameters
            .removeWhere((element) => element.param == paramToBeUpdated.param);
      });

      existingParameters.addAll(params);

      await repository.saveParams(existingParameters);

      return await repository.getParams(existingParameters);
    });
  }

  Future<void> clearParameters() async {
    await repository.clearParams();
  }
}
