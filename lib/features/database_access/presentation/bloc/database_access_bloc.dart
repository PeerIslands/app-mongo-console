import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/use_cases/approve_or_decline_database_request.dart';
import 'package:flutter_auth/features/database_access/domain/use_cases/fetch_database_access_list.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_event.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseAccessBloc
    extends Bloc<DatabaseAccessEvent, DatabaseAccessState> {
  final FetchDatabaseAccessList fetchDatabaseAccessList;
  final ApproveOrDeclineDatabaseRequest approveOrDeclineRequest;

  DatabaseAccessBloc(this.fetchDatabaseAccessList, this.approveOrDeclineRequest)
      : super(Empty());

  @override
  Stream<DatabaseAccessState> mapEventToState(
      DatabaseAccessEvent event) async* {
    if (event is GetDatabaseAccessRequests) {
      yield DatabaseAccessListLoading();

      Either<Failure, List<DatabaseAccess>> failureOrDatabaseAccessList =
          await fetchDatabaseAccessList(NoParams());

      yield* _eitherSuccessListOrNotFound(failureOrDatabaseAccessList);
    } else if (event is ApproveOrDeclineRequest) {
      Either<Failure, Response> failureOrSuccess =
          await approveOrDeclineRequest(
              Params(id: event.id, approve: event.approve));

      yield* _eitherSuccessApprovingOrDecliningOrError(failureOrSuccess);
    }
  }

  Stream<DatabaseAccessState> _eitherSuccessApprovingOrDecliningOrError(
      Either<Failure, Response<dynamic>> failureOrSuccess) async* {
    yield* failureOrSuccess.fold((failure) async* {
      yield DatabaseAccessErrorWhileApprovingOrDeclining(
          message: (failure as ServerFailure).message);
    }, (success) => null);

    yield Empty();
  }

  Stream<DatabaseAccessState> _eitherSuccessListOrNotFound(
      Either<Failure, List<DatabaseAccess>>
          failureOrDatabaseAccessList) async* {
    yield failureOrDatabaseAccessList.fold(
      (failure) =>
          DatabaseAccessListFailed(message: (failure as ServerFailure).message),
      (databaseAccessList) =>
          DatabaseAccessListLoaded(databaseAccessList: databaseAccessList),
    );
  }
}
