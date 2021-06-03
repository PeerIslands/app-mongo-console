import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/shared/domain/entities/menu_item.dart';

@immutable
abstract class BottomMenuState extends Equatable {
  final List<MenuItem> items;

  BottomMenuState({@required this.items});

  @override
  List<Object> get props => [];
}

class Initial extends BottomMenuState {
  Initial({@required List<MenuItem> items}) : super(items: items);

  @override
  List<Object> get props => [items];
}

class ChartMenuOpened extends BottomMenuState {
  ChartMenuOpened({@required List<MenuItem> items}) : super(items: items);

  @override
  List<Object> get props => [items];
}
