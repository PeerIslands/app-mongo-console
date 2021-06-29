import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

import '../../../../core/widgets/material_tile.dart';

class DashboardTileItemHalf extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;
  final Color iconDataColor;
  final Widget redirectTo;

  const DashboardTileItemHalf({
    Key key,
    this.title,
    this.subTitle,
    this.iconData,
    this.iconDataColor,
    this.redirectTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialTile(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return redirectTo;
                        },
                      ),
                    ),
                color: iconDataColor,
                shape: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(iconData,
                      color: dashboardTilesIconColor(context), size: 30.0),
                )),
            Padding(padding: EdgeInsets.only(bottom: 8.0)),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return redirectTo;
                  },
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: dashboardTilesTextColor(context),
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0)),
                  SizedBox(width: 10),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: dashboardTilesTextColor(context),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
