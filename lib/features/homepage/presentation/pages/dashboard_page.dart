import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<DashboardPage> {
  final List<List<double>> charts = [
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: WillPopScope(
        onWillPop: this.handleBackPressed,
        child: Container(
          child: Stack(children: <Widget>[
            Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.lightGreen,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: Color.fromRGBO(73, 82, 85, 1.0),
                  title: Text('Dashboard',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0)),
                ),
                body: StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  padding: EdgeInsets.only(left: 16, right: 16, top: 40),
                  children: <Widget>[
                    _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Connections',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0)),
                                  Text('265',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.account_tree,
                                        color: Colors.white, size: 30.0),
                                  )))
                            ]),
                      ),
                    ),
                    _buildTile(
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Users',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0)),
                                  Text('127',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 34.0))
                                ],
                              ),
                              Material(
                                  color: Color.fromRGBO(73, 82, 85, 1.0),
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(
                                        Icons.supervised_user_circle_rounded,
                                        color: Colors.white,
                                        size: 30.0),
                                  )))
                            ]),
                      ),
                    ),
                    _buildTile(
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.teal,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.settings_applications,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Settings',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0)),
                              Text('Set up connection',
                                  style: TextStyle(color: Colors.black45)),
                            ]),
                      ),
                    ),
                    _buildTile(
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                  color: Colors.amber,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.pie_chart,
                                        color: Colors.white, size: 30.0),
                                  )),
                              Padding(padding: EdgeInsets.only(bottom: 16.0)),
                              Text('Databases',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.0)),
                              Text('Manage access ',
                                  style: TextStyle(color: Colors.black45))
                            ]),
                      ),
                    ),
                    _buildTile(
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Connections',
                                          style:
                                              TextStyle(color: Colors.green)),
                                      Text('\265',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 34.0)),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 4.0)),
                              Sparkline(
                                data: charts[0],
                                lineWidth: 5.0,
                                lineColor: Colors.greenAccent,
                              )
                            ],
                          )),
                    ),
                  ],
                  staggeredTiles: [
                    StaggeredTile.extent(2, 110.0),
                    StaggeredTile.extent(2, 110.0),
                    StaggeredTile.extent(1, 180.0),
                    StaggeredTile.extent(1, 180.0),
                    StaggeredTile.extent(2, 250.0),
                    StaggeredTile.extent(2, 110.0),
                  ],
                )),
            BottomMenuPage(),
          ]),
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(onTap: doNothing, child: child));
  }

  Future<bool> handleBackPressed() {
    if (isBottomSheetOpen) {
      toggleBottomMenu();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
