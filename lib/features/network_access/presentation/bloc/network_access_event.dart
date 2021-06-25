import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NetworkAccessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNetworkAccessRequests extends NetworkAccessEvent {}
