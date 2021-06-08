import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

import '../../../../core/widgets/material_tile.dart';

class DashboardTileItemFull extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;
  final Color iconDataColor;

  const DashboardTileItemFull(
      {Key key, this.title, this.subTitle, this.iconData, this.iconDataColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialTile(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            color: dashboardTilesTextColor(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0)),
                    Text(subTitle,
                        style: TextStyle(
                            color: dashboardTilesTextColor(context),
                            fontWeight: FontWeight.w700,
                            fontSize: 34.0))
                  ],
                ),
                Material(
                    color: iconDataColor,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(iconData,
                              color: dashboardTilesIconColor(context), size: 30.0),
                        )))
              ]),
        ),
    );
  }
}