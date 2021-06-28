import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/features/shared/domain/entities/menu_item.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_bloc.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_state.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/widgets/chart_menu_item.dart';
import 'package:flutter_auth/features/shared/presentation/widgets/close_menu_icon.dart';
import 'package:flutter_auth/features/shared/presentation/widgets/expanded_chart_menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomMenuPage extends StatefulWidget {
  @override
  _BottomMenuPageState createState() => _BottomMenuPageState();
}

class _BottomMenuPageState extends State<BottomMenuPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector<BottomMenuBloc>(),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Positioned(
              height: lerp(minHeight, maxHeight(context)),
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: toggleBottomMenu,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: menuItemColor(context),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: menuPrimaryColor(context),
                    elevation: 10.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: InkWell(
                      onTap: doNothing,
                      splashColor: menuItemColor(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(
                          children: [
                            BlocBuilder<BottomMenuBloc, BottomMenuState>(
                                // ignore: missing_return
                                builder: (context, state) {
                              return Stack(
                                children: <Widget>[
                                  if (state is ChartMenuOpened) CloseMenuIcon(),
                                  for (MenuItem item in state.items)
                                    _constructIconChartMenu(
                                        state, item, context),
                                  for (MenuItem item in state.items)
                                    _constructIcon(state, item, context)
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  ExpandedChartMenuItem _constructIconChartMenu(
      BottomMenuState state, MenuItem item, BuildContext context) {
    return ExpandedChartMenuItem(
      topMargin: iconTopMargin(state.items.indexOf(item), context),
      leftMargin: iconLeftMargin(state.items.indexOf(item)),
      height: iconSize,
      isVisible: controller.status == AnimationStatus.completed,
      borderRadius: itemBorderRadius,
      title: item.title,
    );
  }

  ChartMenuItem _constructIcon(
      BottomMenuState state, MenuItem item, BuildContext context) {
    return ChartMenuItem(index: state.items.indexOf(item), item: item);
  }
}
