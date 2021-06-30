import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends LoginState {}

class Submitting extends LoginState {}

class SubmissionSuccess extends LoginState {
  final User user;

  SubmissionSuccess({@required this.user});

  @override
  List<Object> get props => [user];
}

class SubmissionFailed extends LoginState {
  final String message;

  SubmissionFailed({@required this.message});

  @override
  List<Object> get props => [message];
}
