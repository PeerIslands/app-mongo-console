import 'package:equatable/equatable.dart';

class Roles extends Equatable {
  final String databaseName;
  final String roleName;

  Roles(this.databaseName, this.roleName);

  @override
  List<Object> get props => [databaseName, roleName];
}