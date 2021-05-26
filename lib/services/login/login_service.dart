import 'package:dio/dio.dart';
import '../../models/user_model.dart';

class LoginService {
  Future<UserModel> login(String email, String password) async {
    final api = 'http://10.0.2.2:8000/v1/login';
    final data = {"email": email, "password": password};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      return UserModel(email: email, token: body['token']);
    } else {
      return null;
    }
  }
}
