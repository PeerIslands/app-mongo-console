import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/use_cases/approve_or_decline_database_request.dart';

abstract class DatabaseAccessRepository {
  Future<Either<Failure, List<DatabaseAccess>>> fetchDatabaseAccessRequests();
  Future<Either<Failure, Response>> approveOrDeclineRequest(Params params);
}
