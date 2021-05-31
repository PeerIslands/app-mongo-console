import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/error/failures.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/homepage/domain/entities/user.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/authentication_repository.dart';

class SendSignupForm implements UseCase<User, Params> {
  final AuthenticationRepository repository;

  SendSignupForm(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.signupUser(
        params.email, params.name, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String name;
  final String password;

  Params({@required this.email, @required this.name, @required this.password});

  @override
  List<Object> get props => [email, name, password];
}
