import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String token;

  User({@required this.email, @required this.name, @required this.token});

  @override
  List<Object> get props => [email, name, token];
}
