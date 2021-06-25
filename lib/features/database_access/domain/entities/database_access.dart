import 'package:equatable/equatable.dart';
import 'package:flutter_auth/features/database_access/domain/entities/roles.dart';

class DatabaseAccess extends Equatable {
  final String id;
  final String groupId;
  final String databaseName;
  final String password;
  final List<Roles> roles;
  final String username;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String status;

  DatabaseAccess(
      this.id,
      this.groupId,
      this.databaseName,
      this.password,
      this.roles,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.status);

  @override
  List<Object> get props => [
        id,
        groupId,
        databaseName,
        password,
        roles,
        username,
        createdAt,
        updatedAt,
        createdBy,
        status
      ];
}
