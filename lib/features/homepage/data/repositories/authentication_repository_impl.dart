import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/error/exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<Failure, User>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    try {
      Response response = await ApiBaseHelper()
          .post('login', {"email": email, "password": password});

      if (response.statusCode == 200 &&
          response.data['token'] != "email or password is wrong") {
        return Right(User(email: email, token: response.data['token']));
      } else {
        return throw ServerException();
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signupUser(
      String email, String name, String password) {
    // TODO: implement signupUser
    throw UnimplementedError();
  }
}
