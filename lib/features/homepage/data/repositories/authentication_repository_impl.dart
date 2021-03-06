import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/constants/server_requests.dart';
import 'package:flutter_auth/core/error/dio_exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<Either<Failure, User>> loginUser(String email, String password) async {
    try {
      Response response = await ApiBaseHelper()
          .post(url: LOGIN, data: {"email": email, "password": password});

      return Right(
          User(email: email, password: '', token: response.data['token']));
    } on BadRequestException {
      return Left(ServerFailure(message: AUTHENTICATION_FAILED_MESSAGE));
    } on ServerException {
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, User>> signupUser(
      String email, String name, String password) async {
    try {
      await ApiBaseHelper().post(
          url: USER,
          data: {"email": email, "name": name, "password": password});

      return Right(User(email: email, password: password, token: ''));
    } on BadRequestException catch (error) {
      return Left(
          ServerFailure(message: error.message ?? CREATE_USER_FAILED_MESSAGE));
    } on ServerException {
      return Left(ServerFailure(message: GENERAL_ERROR_MESSAGE));
    }
  }
}
