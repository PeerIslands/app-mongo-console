import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckUserLogged extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedInUser extends AuthenticationEvent {
  final String token;

  LoggedInUser(this.token);

  @override
  List<Object> get props => [token];
}

class LoggedOutUser extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
