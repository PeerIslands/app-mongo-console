import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';

@immutable
abstract class NetworkAccessState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends NetworkAccessState {}

class NetworkAccessListLoading extends NetworkAccessState {}

class NetworkAccessListLoaded extends NetworkAccessState {
  final List<NetworkAccess> networkAccessList;

  NetworkAccessListLoaded({@required this.networkAccessList});

  @override
  List<Object> get props => [networkAccessList];
}

class NetworkAccessListFailed extends NetworkAccessState {
  final String message;

  NetworkAccessListFailed({this.message});

  @override
  List<Object> get props => [message];
}

class NetworkAccessErrorWhileApprovingOrDeclining extends NetworkAccessState {
  final String message;

  NetworkAccessErrorWhileApprovingOrDeclining({this.message});

  @override
  List<Object> get props => [message];
}
