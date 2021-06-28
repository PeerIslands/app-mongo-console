import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/entities/roles.dart';

class DatabaseAccessToSlidableItemConverter {
  SlidableModal convert(DatabaseAccess databaseAccess) {
    if (databaseAccess.isNotNull)
      return SlidableModal(databaseAccess.id, databaseAccess.username,
          _getDatabaseNameAndRoles(databaseAccess.roles));

    return null;
  }

  String _getDatabaseNameAndRoles(List<Roles> roles) {
    return roles.map((role) => '${_getDatabaseName(role.databaseName)}${_getRoleName(role.roleName)}').join('\n');
  }

  String _getDatabaseName(String databaseName) {
    return databaseName.isNotNull && databaseName.isNotEmpty ? 'database: $databaseName' : '';
  }

  String _getRoleName(String role) {
    return role.isNotNull && role.isNotEmpty ? ', role: $role' : '';
  }
}
