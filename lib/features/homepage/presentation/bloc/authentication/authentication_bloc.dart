import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/constants/server_constants.dart';
import 'package:flutter_auth/core/error/failures.dart';
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
          email: event.email, password: event.password));
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
      (failure) => SubmissionFailed(message: _mapFailureToMessage(failure)),
      (user) => SubmissionSuccess(user: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
