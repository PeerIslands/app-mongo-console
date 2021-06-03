import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_bloc.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_event.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CloseMenuIcon extends StatelessWidget {
  const CloseMenuIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 30,
      child: GestureDetector(
        onTap: doNothing,
        child: IconButton(
          icon: Icon(Icons.close, color: menuItemColor(context)),
          onPressed: () {
            context.read<BottomMenuBloc>().add(CloseChartMenu());
            toggleBottomMenu();
          },
        ),
      ),
    );
  }
}
