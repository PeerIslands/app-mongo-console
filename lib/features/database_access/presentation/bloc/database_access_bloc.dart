import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/use_cases/fetch_database_access_list.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_event.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseAccessBloc
    extends Bloc<DatabaseAccessEvent, DatabaseAccessState> {
  final FetchDatabaseAccessList fetchDatabaseAccessList;

  DatabaseAccessBloc(this.fetchDatabaseAccessList) : super(Empty());

  @override
  Stream<DatabaseAccessState> mapEventToState(
      DatabaseAccessEvent event) async* {
    if (event is GetDatabaseAccessRequests) {
      yield DatabaseAccessListLoading();

      Either<Failure, List<DatabaseAccess>> failureOrDatabaseAccessList =
          await fetchDatabaseAccessList(NoParams());

      yield* _eitherSuccessOrErrorState(failureOrDatabaseAccessList);
    }
  }

  Stream<DatabaseAccessState> _eitherSuccessOrErrorState(
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
