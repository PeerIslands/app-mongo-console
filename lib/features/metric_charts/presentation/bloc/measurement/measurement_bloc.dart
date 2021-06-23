import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:enum_to_string/enum_to_string.dart';
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
    if (event is GetConnectionData) {
      await fetchMeasurementParams.clearParameters();

      await _dispatchGetConnectionDataEvent(event);
    } else if (event is GetBytesInBytesOutData) {
      await fetchMeasurementParams.clearParameters();

      await _dispatchGetBytesInBytesOutDataEvent(event);
    } else if (event is GetOpcountersData) {
      await fetchMeasurementParams.clearParameters();

      await _dispatchGetOpcountersDataEvent(event);
    } else if (event is ChangeParams) {
      final params = await fetchMeasurementParams.call(
          FetchMeasurementParamsParams(
              params: _insertParamsToQuery(event),
              isToCallApi: !event.isBaseQuery));

      if (event.isBaseQuery) {
        yield* Stream.value(BaseQueryBuilt());
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

  List<BaseMeasurementQuery> _insertParamsToQuery(ChangeParams event) {
    List<BaseMeasurementQuery> params = [];

    if (event.types != null) {
      event.types.forEach((type) =>
          params.add(ParamMeasurement(EnumToString.convertToString(type))));
    }

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
      params.add(ParamGranularity('P1D'));
    }

    return params;
  }

  Future<void> _dispatchGetConnectionDataEvent(GetConnectionData event) async {
    this.add(ChangeParams(
        types: [MeasurementType.CONNECTIONS],
        process: event.process,
        startDate: event.startDate,
        endDate: event.endDate,
        granularity: 'P1D',
        isBaseQuery: true));
  }

  Future<void> _dispatchGetBytesInBytesOutDataEvent(
      GetBytesInBytesOutData event) async {
    this.add(ChangeParams(
        types: [
          MeasurementType.NETWORK_BYTES_IN,
          MeasurementType.NETWORK_BYTES_OUT,
          MeasurementType.NETWORK_NUM_REQUESTS
        ],
        process: event.process,
        startDate: event.startDate,
        endDate: event.endDate,
        granularity: 'P1D',
        isBaseQuery: true));
  }

  Future<void> _dispatchGetOpcountersDataEvent(
      GetOpcountersData event) async {
    this.add(ChangeParams(
        types: [
          MeasurementType.OPCOUNTER_CMD,
          MeasurementType.OPCOUNTER_QUERY,
        ],
        process: event.process,
        startDate: event.startDate,
        endDate: event.endDate,
        granularity: 'P1D',
        isBaseQuery: true));
  }

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
