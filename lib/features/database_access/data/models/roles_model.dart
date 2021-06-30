import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/features/database_access/domain/entities/roles.dart';

class RolesModel extends Roles {
  RolesModel({@required String databaseName, @required String roleName})
      : super(databaseName, roleName);

  factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
      databaseName: json['databaseName'], roleName: json['roleName']);

  Map<String, dynamic> toJson() =>
      {'databaseName': databaseName, 'roleName': roleName};
}
