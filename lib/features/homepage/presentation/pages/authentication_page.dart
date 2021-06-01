import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';
import 'package:flutter_auth/core/constants/server_constants.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';

import 'dashboard_page.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage(this.isToShowErrorMessage);

  final bool isToShowErrorMessage;

  @override
  Widget build(BuildContext context) {
    if (isToShowErrorMessage) {
      Future.delayed(
          Duration.zero,
          () => CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: AUTHENTICATION_FAILED,
              ));
    }

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
            if (state is Empty) {
              return FlutterLogin(
                  logo: 'assets/images/mongoDB_removed_bg.png',
                  onLogin: (LoginData loginInfo) {
                    return Future.delayed(Duration(milliseconds: 2250))
                        .then((_) {

                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoginSubmitted(loginInfo.name, loginInfo.password));
                      // context.read<AuthenticationBloc>().add(
                      //     LoginSubmitted(loginInfo.name, loginInfo.password));

                      return SERVER_FAILURE_MESSAGE;
                    });
                  });
            } else if (state is SubmissionSuccess) {
              return DashboardPage();
            } else if (state is SubmissionFailed) {
              return AuthenticationPage(true);
            }
          },
        ),
      ),
    );
  }
}
