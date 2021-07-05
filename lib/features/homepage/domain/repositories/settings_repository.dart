import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> updateClientAndSecret(
      {String clientId, String secret});
}