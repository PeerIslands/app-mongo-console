import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_login_form.dart'
    as SendLoginFormClass;
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_signup_form.dart'
    as SendSignupFormClass;
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/login/login_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendLoginFormClass.SendLoginForm sendLoginForm;
  final SendSignupFormClass.SendSignupForm sendSignupForm;

  LoginBloc(
      {@required SendLoginFormClass.SendLoginForm loginForm,
      @required SendSignupFormClass.SendSignupForm signupForm})
      : sendLoginForm = loginForm,
        sendSignupForm = signupForm,
        super(Empty());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      final failureOrLogin = await sendLoginForm(SendLoginFormClass.Params(
          email: event.email.toLowerCase(), password: event.password));
      yield Submitting();
      yield* _eitherSuccessOrErrorState(failureOrLogin, false);
    } else if (event is SignupSubmitted) {
      final failureOrSignup = await sendSignupForm(SendSignupFormClass.Params(
          email: event.email.toLowerCase(),
          name: event.name,
          password: event.password));
      yield Submitting();
      yield* _eitherSuccessOrErrorState(failureOrSignup, true);
    }
  }

  Stream<LoginState> _eitherSuccessOrErrorState(
      Either<Failure, User> failureOrUser, bool signup) async* {
    yield failureOrUser.fold(
      (failure) {
        return SubmissionFailed(message: (failure as ServerFailure).message);
      },
      (user) {
        if (signup) {
          add(LoginSubmitted(user.email, user.password));
        } else {
          injector<AuthenticationBloc>().add(LoggedInUser(user.token));
        }

        return SubmissionSuccess(user: user);
      },
    );
  }
}
