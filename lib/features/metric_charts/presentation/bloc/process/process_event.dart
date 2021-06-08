import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProcessEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDataRequested extends ProcessEvent {}