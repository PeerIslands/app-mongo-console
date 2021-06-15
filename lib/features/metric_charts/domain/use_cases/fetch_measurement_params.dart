import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';

class FetchMeasurementParams
    implements
        UseCase<List<BaseMeasurementQuery>, FetchMeasurementParamsParams> {
  final MeasurementRepository repository;

  FetchMeasurementParams(this.repository);

  @override
  Future<Either<Failure, List<BaseMeasurementQuery>>> call(
      FetchMeasurementParamsParams params) async {
    var paramsToBeUpdatedOrFailure = await repository.getParams(params.params);

    return paramsToBeUpdatedOrFailure.fold((failure) async {
      await repository.saveParams(params.params);

      return Right(params.params);
    }, (existingParameters) async {
      params.params.forEach((paramToBeUpdated) {
        existingParameters
            .removeWhere((element) => element.param == paramToBeUpdated.param);
      });

      existingParameters.addAll(params.params);

      await repository.saveParams(existingParameters);

      if (params.isToCallApi) {
        return await repository.getParams(existingParameters);
      }

      return Right(params.params);
    });
  }

  Future<void> clearParameters() async {
    await repository.clearParams();
  }
}

class FetchMeasurementParamsParams extends Equatable {
  final List<BaseMeasurementQuery> params;
  final bool isToCallApi;

  FetchMeasurementParamsParams({this.params, this.isToCallApi});

  @override
  List<Object> get props => [];
}
