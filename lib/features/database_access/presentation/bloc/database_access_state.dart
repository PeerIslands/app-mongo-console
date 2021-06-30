import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';

@immutable
abstract class DatabaseAccessState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends DatabaseAccessState {}

class DatabaseAccessListLoading extends DatabaseAccessState {}

class DatabaseAccessListLoaded extends DatabaseAccessState {
  final List<DatabaseAccess> databaseAccessList;

  DatabaseAccessListLoaded({@required this.databaseAccessList});

  @override
  List<Object> get props => [databaseAccessList];
}

class DatabaseAccessListFailed extends DatabaseAccessState {
  final String message;

  DatabaseAccessListFailed({this.message});

  @override
  List<Object> get props => [message];
}

class DatabaseAccessErrorWhileApprovingOrDeclining extends DatabaseAccessState {
  final String message;

  DatabaseAccessErrorWhileApprovingOrDeclining({this.message});

  @override
  List<Object> get props => [message];
}
