import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';

class ServerException extends DioError {
  final String message;

  ServerException({this.message = GENERAL_ERROR_MESSAGE});
}

class NotFoundException extends DioError {}

class UnauthorizedException extends DioError {}

class ForbiddenException extends DioError {}

class BadRequestException extends DioError {}
