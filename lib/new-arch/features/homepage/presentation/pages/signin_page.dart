import 'package:flutter/material.dart';
import 'package:flutter_auth/new-arch/core/widgets/rounded_button.dart';
import 'package:flutter_auth/new-arch/core/widgets/rounded_input_field.dart';
import 'package:flutter_auth/new-arch/core/widgets/sidebar_page.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/pages/signup_page.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/widgets/already_have_an_account_acheck.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/widgets/rounded_password_field.dart';
import 'package:flutter_auth/new-arch/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_auth/services/login/login_service.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatelessWidget {
  final _loginService = LoginService();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                      final test = await _loginService.login(
                          emailController.text.toLowerCase(),
                          passwordController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardPage();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
