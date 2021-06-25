import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/database_access/data/models/roles_model.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';

class DatabaseAccessModel extends DatabaseAccess {
  DatabaseAccessModel(
      {@required id,
      @required groupId,
      @required databaseName,
      @required password,
      @required roles,
      @required username,
      @required createdAt,
      @required updatedAt,
      @required createdBy,
      @required status})
      : super(id, groupId, databaseName, password, roles, username, createdAt,
            updatedAt, createdBy, status);

  factory DatabaseAccessModel.fromJson(Map<String, dynamic> json) =>
      DatabaseAccessModel(
          id: json['id'],
          groupId: json['groupId'],
          databaseName: json['databaseName'],
          password: json['password'],
          username: json['username'],
          createdAt: json['CreatedAt'],
          updatedAt: json['UpdatedAt'],
          createdBy: json['CreatedBy'],
          status: json['Status'],
          roles: json['roles'] != null
              ? ((json['roles'] as List)
                  .map((role) => RolesModel.fromJson(role))
                  .toList())
              : []);

  Map<String, dynamic> toJson() => {
        'id': id,
        'groupId': groupId,
        'databaseName': databaseName,
        'password': password,
        'username': username,
        'CreatedAt': createdAt,
        'UpdatedAt': updatedAt,
        'CreatedBy': createdBy,
        'Status': status,
        'roles': roles != null
            ? (roles as List<RolesModel>).map((v) => v.toJson()).toList()
            : []
      };
}
