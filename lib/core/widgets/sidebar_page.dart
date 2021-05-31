import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/authentication_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/bar_chart_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/bar_chart_page2.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/bar_chart_page3.dart';

class SidebarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/mongo_wallpaper.jpeg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_sharp),
            title: Text('Chart 1'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BarChartPage();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.pie_chart),
            title: Text('Chart 2'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BarChartPage2();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.stacked_bar_chart),
            title: Text('Chart 3'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BarChartPage3();
                  },
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuthenticationPage(false);
                  },
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}
