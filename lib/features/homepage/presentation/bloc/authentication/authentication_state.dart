import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AuthenticationState {}

class Submitting extends AuthenticationState {}

class SubmissionSuccess extends AuthenticationState {
  final User user;

  SubmissionSuccess({@required this.user});

  @override
  List<Object> get props => [user];
}

class SubmissionFailed extends AuthenticationState {
  final String message;

  SubmissionFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

