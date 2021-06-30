import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';
import 'package:flutter_auth/features/network_access/domain/repositories/network_access_repository.dart';

class FetchNetworkAccessList implements UseCase<List<NetworkAccess>, NoParams> {
  final NetworkAccessRepository repository;

  FetchNetworkAccessList(this.repository);

  @override
  Future<Either<Failure, List<NetworkAccess>>> call(NoParams params) async {
    return await repository.fetchNetworkAccessRequests();
  }
}
