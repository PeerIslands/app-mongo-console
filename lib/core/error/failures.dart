import 'package:equatable/equatable.dart';
import 'package:flutter_auth/core/constants/message_constants.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = GENERAL_ERROR_MESSAGE});
}
