import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/shared/domain/entities/menu_item.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_bloc.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_event.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartMenuItem extends StatelessWidget {
  final int index;
  final MenuItem item;

  const ChartMenuItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: iconSize,
      width: iconSize,
      top: iconTopMargin(index, context),
      left: iconLeftMargin(index),
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: IconButton(
            icon: item.icon,
            onPressed: () {
              if (item.title.toLowerCase() == 'logout') {
                context.read<AuthenticationBloc>().add(LoggedOutUser());
              } else if (item.openSideBar) {
                context.read<BottomMenuBloc>().add(ChartItemPressed());
                toggleBottomMenu();
              } else if (item.redirectTo != null) {
                context.pushMaterialPage(item.redirectTo);
              }
            },
          ),
        ),
      ),
    );
  }
}
