import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/login/login_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';

import 'dashboard_page.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (_) => injector<LoginBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: primaryColor(buildContext),
          textTheme: TextTheme(
            button: TextStyle(
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        home: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            // ignore: missing_return
            builder: (context, state) {
              return FlutterLogin(
                logo: 'assets/images/mongo_peer_login.png',
                hideForgotPasswordButton: true,
                onLogin: (LoginData loginInfo) {
                  context
                      .read<LoginBloc>()
                      .add(LoginSubmitted(loginInfo.name, loginInfo.password));

                  return _checkIfLoginSucceed(context);
                },
                onSubmitAnimationCompleted: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DashboardPage();
                      },
                    ),
                  );
                },
                theme: buildLoginTheme(buildContext),
                onRecoverPassword: (_) => Future.value(''),
                onSignup: (LoginData signupForm) {
                  context.read<LoginBloc>().add(SignupSubmitted(
                      signupForm.name, signupForm.name, signupForm.password));

                  return _checkIfSignUpSucceed(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  LoginTheme buildLoginTheme(BuildContext context) {
    return LoginTheme(
      primaryColor: loginPrimaryColor(context),
      pageColorLight: primaryColor(context),
      pageColorDark: loginSecondaryColor(context),
      cardTheme: CardTheme(
        color: loginCardColor(context),
        elevation: 5,
        margin: EdgeInsets.only(top: 15),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(100.0)),
      ),
      bodyStyle: TextStyle(
        color: loginBodyColor(context),
        fontStyle: FontStyle.italic,
      ),
      inputTheme: InputDecorationTheme(
        filled: true,
        fillColor: loginInputsColor(context),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Future<String> _checkIfSignUpSucceed(BuildContext context) {
    return Future.delayed(Duration(milliseconds: 2500)).then((_) {
      final signupSucceed = context.read<LoginBloc>().state;
      if (signupSucceed is Submitting) {
        return _checkIfSignUpSucceed(context);
      }
      if (signupSucceed is SubmissionFailed)
        return signupSucceed.message;
      else
        return null;
    });
  }

  Future<String> _checkIfLoginSucceed(BuildContext context) {
    return Future.delayed(Duration(milliseconds: 2500)).then((_) {
      final loginSucceed = context.read<LoginBloc>().state;
      if (loginSucceed is Submitting) {
        return _checkIfLoginSucceed(context);
      }
      if (loginSucceed is SubmissionFailed)
        return loginSucceed.message;
      else
        return null;
    });
  }
}
