import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/authentication_page.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/bar_chart_page.dart';

class SidebarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(73, 82, 85, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DashboardPage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.stacked_bar_chart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BarChartPage();
                    },
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.supervised_user_circle_sharp, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthenticationPage();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
