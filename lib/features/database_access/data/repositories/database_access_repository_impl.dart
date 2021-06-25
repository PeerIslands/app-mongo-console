import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/dio_exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/database_access/data/models/database_access_model.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/repositories/database_access_repository.dart';

class DatabaseAccessRepositoryImpl extends DatabaseAccessRepository {
  @override
  Future<Either<Failure, List<DatabaseAccess>>>
      fetchDatabaseAccessRequests() async {
    try {
      Response response =
          await ApiBaseHelper().get(DB_ACCESS_LIST, {});

      return Right((response.data as List)
          .map((databaseAccess) => DatabaseAccessModel.fromJson(databaseAccess))
          .toList());
    } on NotFoundException {
      return Left(ServerFailure());
    }
  }
}
