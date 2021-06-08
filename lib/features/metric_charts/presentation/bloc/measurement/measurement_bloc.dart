import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/server_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_measurement_data.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementBloc
    extends Bloc<MeasurementEvent, MeasurementState> {

  final FetchMeasurementData fetchMeasurementData;

  MeasurementBloc(this.fetchMeasurementData) : super(Empty());
  
  @override
  Stream<MeasurementState> mapEventToState (MeasurementEvent event) async* {
    if (event is FetchDataRequested) {
      final failureOrDataLoaded = await fetchMeasurementData(Params(params: event.params));
      yield DataLoading();
      yield* _eitherSuccessOrErrorState(failureOrDataLoaded);
    }
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
        return 'Unexpected error';
    }
  }
}