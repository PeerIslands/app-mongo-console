import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/constants/storage_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_login_form.dart'
    as SendLoginFormClass;
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_signup_form.dart'
    as SendSignupFormClass;
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SendLoginFormClass.SendLoginForm sendLoginForm;
  final SendSignupFormClass.SendSignupForm sendSignupForm;

  AuthenticationBloc(
      {@required SendLoginFormClass.SendLoginForm loginForm,
      @required SendSignupFormClass.SendSignupForm signupForm})
      : sendLoginForm = loginForm,
        sendSignupForm = signupForm,
        super(Empty());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginSubmitted) {
      final failureOrLogin = await sendLoginForm(SendLoginFormClass.Params(
          email: event.email.toLowerCase(), password: event.password));
      yield Submitting();
      yield* _eitherSuccessOrErrorState(failureOrLogin);
    } else if (event is SignupSubmitted) {
      final failureOrSignup = await sendSignupForm(SendSignupFormClass.Params(
          email: event.email, name: event.name, password: event.password));
      yield Submitting();
      yield* _eitherSuccessOrErrorState(failureOrSignup);
    }
  }

  Stream<AuthenticationState> _eitherSuccessOrErrorState(
      Either<Failure, User> failureOrUser) async* {
    yield failureOrUser.fold(
      (failure) {
        return SubmissionFailed(message: (failure as ServerFailure).message);
      },
      (user) {
        ApiBaseHelper.storage.write(key: BEARER_TOKEN, value: user.token);

        return SubmissionSuccess(user: user);
      },
    );
  }
}
