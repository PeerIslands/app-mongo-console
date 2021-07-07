import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/entities/slidable_modal.dart';
import 'package:flutter_auth/core/entities/slidable_on_tap_options.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/util/common_functions.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/core/widgets/slidable_with_delegates.dart';
import 'package:flutter_auth/features/network_access/domain/entities/network_access.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_bloc.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_event.dart';
import 'package:flutter_auth/features/network_access/presentation/bloc/network_access_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkRequestItem extends StatelessWidget {
  final NetworkAccess item;

  final NetworkAccessListLoaded state;
  final int index;

  NetworkRequestItem({Key key, this.item, this.state, this.index})
      : super(key: key);

  final List<SlidableOnTapOptions> slidableOptions = [
    SlidableOnTapOptions('Decline', Colors.redAccent, Icons.thumb_down,
        'IP Address will be declined', false),
    SlidableOnTapOptions('Accept', Colors.lightGreen, Icons.thumb_up,
        'IP Address will be accept', true),
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
              child: Text('${item.comment.substring(0, 2).toUpperCase()}'),
              foregroundColor: invertColorsLightToDark(context),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  item.comment,
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
            title: Text('cidrBlock'),
            subtitle: Text(item.cidrBlock.valueOrNullString)),
        ListTile(
            title: Text('comment'),
            subtitle: Text(item.comment.valueOrNullString)),
        ListTile(
            title: Text('groupId'),
            subtitle: Text(item.groupId.valueOrNullString)),
        ListTile(
            title: Text('deleteAfterDate'),
            subtitle: Text(item.deleteAfterDate.valueOrNullString)),
        ListTile(
            title: Text('status'),
            subtitle: Text(item.status.valueOrNullString)),
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
            context.read<NetworkAccessBloc>().add(
                  ApproveOrDeclineRequest(item.id, approve),
                )
          },
        ),
      ],
    );
  }
}
