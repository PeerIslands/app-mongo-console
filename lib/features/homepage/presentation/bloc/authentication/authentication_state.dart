import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Processing extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthenticationState {
  @override
  List<Object> get props => [];
}
