import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';

import 'dashboard_page.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<AuthenticationBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          textTheme: TextTheme(
            headline3: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 45.0,
              color: Colors.white,
            ),
            button: TextStyle(
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          // ignore: missing_return
          builder: (context, state) {
            return FlutterLogin(
              logo: 'assets/images/mongo_peer_login.png',
              loginProviders: [],
              onLogin: (LoginData loginInfo) {
                context
                    .read<AuthenticationBloc>()
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
            );
          },
        ),
      ),
    );
  }

  Future<String> _checkIfLoginSucceed(BuildContext context) {
    return Future.delayed(Duration(milliseconds: 2500)).then((_) {
      final loginSucceed = context.read<AuthenticationBloc>().state;
      if (loginSucceed is Submitting) {
        return _checkIfLoginSucceed(context);
      }
      if (loginSucceed is SubmissionFailed)
        return AUTHENTICATION_FAILED;
      else
        return null;
    });
  }
}
