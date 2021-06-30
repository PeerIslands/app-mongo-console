import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/database_access/domain/repositories/database_access_repository.dart';

class ApproveOrDeclineDatabaseRequest implements UseCase<Response, Params> {
  final DatabaseAccessRepository repository;

  ApproveOrDeclineDatabaseRequest(this.repository);

  @override
  Future<Either<Failure, Response>> call(Params params) async {
    return await repository.approveOrDeclineRequest(params);
  }
}

class Params extends Equatable {
  final String id;
  final bool approve;

  Params({@required this.id, @required this.approve});

  @override
  List<Object> get props => [approve];
}
