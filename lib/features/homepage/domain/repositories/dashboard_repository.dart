import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard.dart';

abstract class DashboardRepository {
  Future<Either<Failure, Dashboard>> getDashboardData({String groupId});
}
