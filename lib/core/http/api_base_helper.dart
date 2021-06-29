import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_auth/core/constants/server_paths.dart';
import 'package:flutter_auth/core/constants/storage_constants.dart';
import 'package:flutter_auth/core/error/dio_exceptions.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiBaseHelper {
  static final String url =
      Platform.isIOS ? HTTP_SERVER_URL_IOS : HTTP_SERVER_URL_ANDROID;
  static final storage = new FlutterSecureStorage();

  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Future<Dio> addInterceptors(Dio dio) async {
    return dio
      ..interceptors.add(InterceptorsWrapper(
        onError: (error, errorInterceptorHandler) {
          switch (error.response.statusCode) {
            case 400:
              throw BadRequestException();
            case 401:
              injector<AuthenticationBloc>().add(LoggedOutUser());
              throw UnauthorizedException();
            case 403:
              throw ForbiddenException();
            case 404:
              throw NotFoundException();
            case 500:
              throw ServerFailure(message: error.message);
          }
        },
        onRequest: (request, requestInterceptorHandler) async {
          return requestInterceptorHandler
              .next(await requestInterceptor(request));
        },
      ));
  }

  static Future<RequestOptions> requestInterceptor(
      RequestOptions options) async {
    String token = await storage.read(key: BEARER_TOKEN);

    if (token != null)
      return options..headers.addAll({"Authorization": "Bearer $token"});

    return options;
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response> get(String url, Map<String, dynamic> queryParams) async =>
      await (await baseAPI).get(url, queryParameters: queryParams);

  Future<Response> post(
      {String url, dynamic data, Map<String, dynamic> queryParams}) async =>
      await (await baseAPI).post(url, data: data);

  Future<Response> put(String url, dynamic data) async =>
      await (await baseAPI).put(url, data: data);

  Future<Response> delete(String url) async =>
      await (await baseAPI).delete(url);
}
