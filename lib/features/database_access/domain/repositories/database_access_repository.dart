import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';

abstract class DatabaseAccessRepository {
  Future<Either<Failure, List<DatabaseAccess>>> fetchDatabaseAccessRequests();
}
