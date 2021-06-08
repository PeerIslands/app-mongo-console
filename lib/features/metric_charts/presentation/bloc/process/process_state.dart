import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/process.dart';

@immutable
abstract class ProcessState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ProcessState {}

class DataLoading extends ProcessState {}

class DataLoaded extends ProcessState {
  final List<Process> processes;

  DataLoaded({@required this.processes});

  @override
  List<Object> get props => [processes];
}

class DataFailed extends ProcessState {
  final String message;

  DataFailed({@required this.message});

  @override
  List<Object> get props => [message];
}