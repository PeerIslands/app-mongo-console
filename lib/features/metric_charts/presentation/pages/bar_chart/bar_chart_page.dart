import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/bottom_sheet_menu.dart';
import 'package:flutter_auth/core/widgets/sidebar_page.dart';

import 'samples/bar_chart_sample1.dart';

class BarChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
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
              bottomNavigationBar: SidebarPage(),
              body: Container(
                color: Colors.lightGreen,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: BarChartSample1(),
                  ),
                ),
              ),
            ),
            SexyBottomSheet(),
          ]),
        ),
      ),
    );
  }

  Future<bool> handleBackPressed() {
    if (isBottomSheetOpen) {
      toggleBottomSheet();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
