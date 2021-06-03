import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';

import '../widgets/bar_chart_item.dart';

class ConnectionsChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: handleBackPressed,
        child: Container(
          child: Stack(children: <Widget>[
            Scaffold(
              appBar: AppBarDefault(title: 'Connections Chart'),
              body: Container(
                color: primaryColor(context),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: BarChartItem(),
                  ),
                ),
              ),
            ),
            BottomMenuPage(),
          ]),
        ),
      ),
      floatingActionButton: FloatingDarkLightModeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
