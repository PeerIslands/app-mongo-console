import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';
import 'package:flutter_auth/features/network_access/domain/use_cases/approve_or_decline_network_request.dart';

abstract class NetworkAccessRepository {
  Future<Either<Failure, List<NetworkAccess>>> fetchNetworkAccessRequests();
  Future<Either<Failure, Response>> approveOrDeclineRequest(Params params);
}