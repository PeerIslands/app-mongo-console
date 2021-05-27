import 'package:flutter/material.dart';
import 'package:flutter_auth/new-arch/core/util/constants.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_login/flutter_login.dart';

class SignInPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        accentColor: Color(0xFF74A049),
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.white,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: FlutterLogin(
        logo: 'assets/images/mongoDB_removed_bg.png',
        onLogin: _authUser,
        onSignup: _authUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
