import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';

import 'samples/bar_chart_sample1.dart';

class BarChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: this.handleBackPressed,
        child: Container(
          child: Stack(children: <Widget>[
            Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color.fromRGBO(73, 82, 85, 1.0),
                title: Text('Metrics',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0)),
              ),
              body: Container(
                color: primaryColor(context),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: BarChartSample1(),
                  ),
                ),
              ),
            ),
            BottomMenuPage(),
          ]),
        ),
      ),
    );
  }

  Future<bool> handleBackPressed() {
    if (isBottomSheetOpen) {
      toggleBottomMenu();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
