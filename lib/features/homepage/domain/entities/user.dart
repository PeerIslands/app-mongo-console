import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String email;
  final String password;
  final String token;

  User({@required this.email, @required this.password, @required this.token});

  @override
  List<Object> get props => [email, token];
}
