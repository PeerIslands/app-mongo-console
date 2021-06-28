import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MenuEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChartItemPressed extends MenuEvent {}

class CloseChartMenu extends MenuEvent {}

class LogoutPressed extends MenuEvent {}
