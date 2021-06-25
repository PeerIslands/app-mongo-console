import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/dio_exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/network_access/data/models/network_access_model.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';
import 'package:flutter_auth/features/network_access/domain/repositories/network_access_repository.dart';

class NetworkAccessRepositoryImpl implements NetworkAccessRepository {
  @override
  Future<Either<Failure, List<NetworkAccess>>>
      fetchNetworkAccessRequests() async {
    try {
      Response response = await ApiBaseHelper().get(NETWORK_ACCESS_LIST, {});

      return Right((response.data as List)
          .map((network) => NetworkAccessModel.fromJson(network))
          .toList());
    } on NotFoundException {
      return Left(ServerFailure());
    }
  }
}
