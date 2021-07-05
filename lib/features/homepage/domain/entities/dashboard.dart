import 'package:equatable/equatable.dart';

class Dashboard extends Equatable {
  final NumAccess numAccess;
  final NumDB numDbUsers;

  Dashboard(this.numAccess, this.numDbUsers);

  @override
  List<Object> get props => [this.numAccess, this.numDbUsers];
}

class NumAccess extends Equatable {
  final int totalCount;

  NumAccess(this.totalCount);

  @override
  List<Object> get props => [this.totalCount];
}

class NumDB extends Equatable {
  final int totalCount;

  NumDB(this.totalCount);

  @override
  List<Object> get props => [this.totalCount];
}
