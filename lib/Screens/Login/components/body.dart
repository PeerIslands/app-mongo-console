import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import '../../../services/login/login_service.dart';
import '../../../models/user_model.dart';
import '../../../Screens/Home/home_view.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
  }) : super(key: key);

  final _loginService = LoginService();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                emailController.text = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                passwordController.text = value;
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                UserModel user = await _loginService.login(
                    emailController.text.toLowerCase(),
                    passwordController.text);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomeView(user: user)));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
