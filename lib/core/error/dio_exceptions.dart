import 'package:dio/dio.dart';

class ServerException extends DioError {}

class NotFoundException extends DioError {}

class UnauthorizedException extends DioError {}

class ForbiddenException extends DioError {}

class BadRequestException extends DioError {}
