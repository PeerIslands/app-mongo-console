import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/server_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_process_data.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_event.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProcessBloc
    extends Bloc<ProcessEvent, ProcessState> {

  final FetchProcessData fetchProcessData;

  ProcessBloc(this.fetchProcessData) : super(Empty());

  @override
  Stream<ProcessState> mapEventToState (ProcessEvent event) async* {
    if (event is FetchDataRequested) {
      final failureOrDataLoaded = await fetchProcessData(NoParams());
      yield DataLoading();
      yield* _eitherSuccessOrErrorState(failureOrDataLoaded);
    }
  }

  Stream<ProcessState> _eitherSuccessOrErrorState(
      Either<Failure, List<Process>> failureOrMeasurement) async* {
    yield failureOrMeasurement.fold(
          (failure) => DataFailed(message: _mapFailureToMessage(failure)),
          (processes) => DataLoaded(processes: processes),
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