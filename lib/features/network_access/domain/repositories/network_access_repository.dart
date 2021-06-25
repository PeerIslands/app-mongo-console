import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';

abstract class NetworkAccessRepository {
  Future<Either<Failure, List<NetworkAccess>>> fetchNetworkAccessRequests();
}