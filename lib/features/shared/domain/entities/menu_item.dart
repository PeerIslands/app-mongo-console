import 'package:flutter/cupertino.dart';

class MenuItem {
  final Icon icon;
  final Widget redirectTo;
  final bool openSideBar;
  final String title;

  MenuItem(this.icon, this.redirectTo, this.openSideBar, this.title);
}