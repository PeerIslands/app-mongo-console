import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

import 'menu_item_tile.dart';

class ExpandedChartMenuItem extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;
  final double borderRadius;
  final String title;
  final Widget redirectTo;

  const ExpandedChartMenuItem(
      {Key key,
      this.topMargin,
      this.height,
      this.isVisible,
      this.borderRadius,
      this.title,
      this.leftMargin,
      this.redirectTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: MenuItemTile(
          color: menuItemTileColor(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 100.0,
                ),
                child: TextButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return redirectTo;
                        },
                      ),
                    )
                  },
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: menuItemColor(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
