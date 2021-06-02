import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({
    this.child,
    this.color,
    this.splashColor,
    this.onTap,
  });
  final Widget child;
  final Color color;
  final Color splashColor;
  final Function() onTap;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: Color(0x80718792),
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}