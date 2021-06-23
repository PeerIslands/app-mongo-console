import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
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
    if (event is GetConnectionData ||
        event is GetBytesInBytesOutData ||
        event is GetOpcountersData ||
        event is GetLogicalSizeData) {
      await fetchMeasurementParams.clearParameters();

      await _dispatchGetMeasurementMetrics(event);
    } else if (event is ChangeParams) {
      final params = await fetchMeasurementParams.call(
          FetchMeasurementParamsParams(
              params: event.buildMeasurementQuery().toList(),
              isToCallApi: !event.isBaseQuery));

      if (event.isBaseQuery) {
        yield BaseQueryBuilt();
      } else {
        yield* params.fold(
            (failure) => Stream.value(
                DataFailed(message: _mapFailureToMessage(failure))),
            (params) async* {
          yield DataLoading();

          Either<Failure, Measurement> failureOrMeasurement =
              await fetchMeasurementData(Params(params: params));

          yield* _eitherSuccessOrErrorState(failureOrMeasurement);
        });
      }
    }
  }

  Future<void> _dispatchGetMeasurementMetrics(GetMeasurementMetricData event) async => this.add(ChangeParams(
        types: event.queryTypes,
        granularity: 'P1D',
        isBaseQuery: true));

  Stream<MeasurementState> _eitherSuccessOrErrorState(
      Either<Failure, Measurement> failureOrMeasurement) async* {
    yield failureOrMeasurement.fold(
      (failure) => DataFailed(message: _mapFailureToMessage(failure)),
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
