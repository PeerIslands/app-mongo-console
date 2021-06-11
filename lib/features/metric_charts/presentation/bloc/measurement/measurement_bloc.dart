import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/enums/measurement_type_enum.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_measurement_data.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_measurement_params.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final FetchMeasurementData fetchMeasurementData;
  final FetchMeasurementParams fetchMeasurementParams;

  MeasurementBloc(this.fetchMeasurementData, this.fetchMeasurementParams)
      : super(Empty());

  @override
  Stream<MeasurementState> mapEventToState(MeasurementEvent event) async* {
    if (event is ClearParams) {
      await fetchMeasurementParams.clearParameters();
    } else if (event is ChangeParams) {
      final params =
          await fetchMeasurementParams.call(_insertParamsToQuery(event));

      yield* params.fold(
          (failure) =>
              Stream.value(DataFailed(message: _mapFailureToMessage(failure))),
          (params) async* {
        params.forEach((element) {
          print('${element.param}: ${element.value}');
        });
        Either<Failure, Measurement> failureOrMeasurement =
            await fetchMeasurementData(Params(params: params));

        yield* _eitherSuccessOrErrorState(failureOrMeasurement);
      });
    } else if (event is GetConnectionData) {
      await _dispatchGetConnectionDataEvent(event);
    }
  }

  List<BaseMeasurementQuery> _insertParamsToQuery(ChangeParams event) {
    List<BaseMeasurementQuery> params = [];

    if (event.process != null) {
      params.add(PathGroup(event.process.groupId));
      params.add(PathProcess(event.process.id));
    }

    if (event.startDate != null) {
      params.add(ParamStDate("${event.startDate.toIso8601String()}Z"));
    }
    if (event.endDate != null) {
      params.add(ParamEndDate("${event.endDate.toIso8601String()}Z"));
    }

    if (event.granularity != null) {
      params.add(ParamGranularity('PT24H'));
    }
    return params;
  }

  Future<void> _dispatchGetConnectionDataEvent(GetConnectionData event) async {
    this.add(ChangeParams(
        type: MeasurementType.CONNECTIONS,
        process: event.process,
        startDate: event.startDate,
        endDate: event.endDate,
        granularity: 'PT24H'));
  }

  Stream<MeasurementState> _eitherSuccessOrErrorState(
      Either<Failure, Measurement> failureOrMeasurement) async* {
    yield failureOrMeasurement.fold(
      (failure) {
        return DataFailed(message: _mapFailureToMessage(failure));
      },
      (measurement) => DataLoaded(measurement: measurement),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return GENERAL_ERROR_MESSAGE;
    }
  }
}
