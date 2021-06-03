import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';

class DashboardTile extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const DashboardTile({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 14.0,
      color: dashboardTilesColor(context),
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x807B7B7B),
      child: InkWell(onTap: doNothing, child: child),
    );
  }
}
