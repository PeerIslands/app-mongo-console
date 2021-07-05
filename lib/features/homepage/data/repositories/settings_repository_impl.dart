import 'package:dartz/dartz.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<Either<Failure, bool>> updateClientAndSecret(
      {String clientId, String secret}) async {
    try {
      await ApiBaseHelper()
          .put(url: USER, data: {"public_key": clientId, "private_key": secret});

      return Right(true);
    } on Exception {
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
    }
  }
}
