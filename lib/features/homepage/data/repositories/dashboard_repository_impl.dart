import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/homepage/data/models/dashboard_model.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<Either<Failure, Dashboard>> getDashboardData({String groupId}) async {
    try {
      var response = await ApiBaseHelper().get(DASHBOARD, {"group_id": groupId});

      return Right(DashboardModel.fromJson(response.data));
    } on Exception catch(e) {
      print(e);

      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
    }
  }
}
