import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/entities/slidable_on_tap_options.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/util/common_functions.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/core/widgets/slidable_with_delegates.dart';
import 'package:flutter_auth/features/database_access/domain/entities/database_access.dart';
import 'package:flutter_auth/features/database_access/domain/entities/roles.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_bloc.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_event.dart';
import 'package:flutter_auth/features/database_access/presentation/bloc/database_access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseRequestItem extends StatelessWidget {
  final DatabaseAccess item;

  final DatabaseAccessListLoaded state;
  final int index;

  DatabaseRequestItem({Key key, this.item, this.state, this.index})
      : super(key: key);

  final List<SlidableOnTapOptions> slidableOptions = [
    SlidableOnTapOptions('Decline', Colors.redAccent, Icons.thumb_down,
        'User request will be declined', false),
    SlidableOnTapOptions('Accept', Colors.lightGreen, Icons.thumb_up,
        'User request will accept', true),
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: getRandomColor(),
              child: Text('${item.username.substring(0, 2).toUpperCase()}'),
              foregroundColor: invertColorsLightToDark(context),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  item.username,
                  style: TextStyle(
                    color: invertColorsDarkToLight(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        ListTile(title: Text('id'), subtitle: Text(item.id.valueOrNullString)),
        ListTile(
            title: Text('roles'),
            subtitle: Text(_getDatabaseNameAndRoles(item.roles))),
        ListTile(
            title: Text('groupId'),
            subtitle: Text(item.groupId.valueOrNullString)),
        ListTile(
            title: Text('username'),
            subtitle: Text(item.username.valueOrNullString)),
        ListTile(
            title: Text('password'),
            subtitle: Text(item.password.valueOrNullString)),
        ListTile(
            title: Text('databaseName'),
            subtitle: Text(item.databaseName.valueOrNullString)),
        ListTile(
            title: Text('username'),
            subtitle: Text(item.username.valueOrNullString)),
        ListTile(
            title: Text('createdAt'),
            subtitle: Text(item.createdAt.valueOrNullString)),
        ListTile(
            title: Text('createdBy'),
            subtitle: Text(item.createdBy.valueOrNullString)),
        SlidableWithDelegates(
          context: context,
          item: SlidableModal(item.id, 'actions', '', false),
          options: slidableOptions,
          callback: (bool approve) => {
            context.read<DatabaseAccessBloc>().add(
                  ApproveOrDeclineRequest(item.id, approve),
                )
          },
        ),
      ],
    );
  }

  String _getDatabaseNameAndRoles(List<Roles> roles) {
    return roles
        .map((role) =>
            '${_getDatabaseName(role.databaseName)}${_getRoleName(role.roleName)}')
        .join('\n');
  }

  String _getDatabaseName(String databaseName) {
    return databaseName.isNotNull && databaseName.isNotEmpty
        ? 'database: $databaseName'
        : '';
  }

  String _getRoleName(String role) {
    return role.isNotNull && role.isNotEmpty ? ', role: $role' : '';
  }
}
