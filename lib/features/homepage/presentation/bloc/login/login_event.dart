import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignupSubmitted extends LoginEvent {
  final String email;
  final String name;
  final String password;

  SignupSubmitted(this.email, this.name, this.password);

  @override
  List<Object> get props => [email, name, password];
}

class ForgotPassword extends LoginEvent {
  final String email;

  ForgotPassword(this.email);

  @override
  List<Object> get props => [email];
}

class LogoutSubmitted extends LoginEvent {}
