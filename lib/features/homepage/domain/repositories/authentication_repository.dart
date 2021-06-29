import 'package:dartz/dartz.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';

import '../../../../core/error/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> loginUser(String email, String password);

  Future<Either<Failure, User>> signupUser(
      String email, String name, String password);
}
