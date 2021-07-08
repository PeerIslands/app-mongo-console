import 'dart:io';

class EnvironmentConfig {
  static const String APP_ENV =
      String.fromEnvironment('APP_ENV', defaultValue: 'Dev');
  static const String APP_NAME =
      APP_ENV == 'Dev' ? '(Dev) MongoDB Atlas Admin' : 'MongoDB Atlas Admin';
  static const String _HTTP_SERVER_URL_ANDROID = 'http://10.0.2.2:8000/v1/';
  static const String _HTTP_SERVER_URL_IOS = 'http://localhost:8000/v1/';

  static final String API_PATH = APP_ENV == 'Dev'
        ? Platform.isIOS
            ? _HTTP_SERVER_URL_IOS
            : _HTTP_SERVER_URL_ANDROID
        : 'PUT_PROD_URL_HERE';
}
