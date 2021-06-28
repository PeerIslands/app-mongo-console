import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DatabaseAccessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDatabaseAccessRequests extends DatabaseAccessEvent {}

class ApproveOrDeclineRequest extends DatabaseAccessEvent {
  final String id;
  final bool approve;

  ApproveOrDeclineRequest(this.id, this.approve);
}