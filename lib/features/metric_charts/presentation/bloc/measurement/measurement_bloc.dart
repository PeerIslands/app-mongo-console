import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_measurement_data.dart';
import 'package:flutter_auth/features/metric_charts/domain/util/measurement_queries.dart';
import 'package:flutter_auth/features/metric_charts/domain/util/measurement_type_enum.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final FetchMeasurementData fetchMeasurementData;

  MeasurementBloc(this.fetchMeasurementData) : super(Empty());

  @override
  Stream<MeasurementState> mapEventToState(MeasurementEvent event) async* {
    if (event is ProcessChanged) {
      yield ProcessSelected(event.process);
    }
    if (event is GetConnectionData) {
      Either<Failure, Measurement> failureOrMeasurement =
          await _getConnectionDataHandler(event);
      yield DataLoading();
      yield* _eitherSuccessOrErrorState(failureOrMeasurement);
    }
  }

  Future<Either<Failure, Measurement>> _getConnectionDataHandler(
      GetConnectionData event) async {
    var params = [
      PathGroup(event.process.groupId),
      PathProcess(event.process.id),
      ParamGranularity('PT24H'),
      ParamMeasurement(EnumToString.convertToString(MeasurementType.CONNECTIONS)),
      ParamStDate("${event.startDate.toIso8601String()}Z"),
      ParamEndDate("${event.endDate.toIso8601String()}Z")
    ];

    return await fetchMeasurementData(Params(params: params));
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
