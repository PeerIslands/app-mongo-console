import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/repositories/database_access_repository.dart';

class FetchDatabaseAccessList
    implements UseCase<List<DatabaseAccess>, NoParams> {
  final DatabaseAccessRepository repository;

  FetchDatabaseAccessList(this.repository);

  @override
  Future<Either<Failure, List<DatabaseAccess>>> call(NoParams params) async {
    return await repository.fetchDatabaseAccessRequests();
  }
}
