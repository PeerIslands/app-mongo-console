import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/floating_dark_light_mode_button.dart';
import 'package:flutter_auth/core/widgets/material_tile.dart';
import 'package:flutter_auth/features/homepage/presentation/widgets/dashboard_tile_item_full.dart';
import 'package:flutter_auth/features/homepage/presentation/widgets/dashboard_tile_item_half.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/bar_chart_thick_measurement.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: handleBackPressed,
        child: Container(
          child: Stack(children: <Widget>[
            Scaffold(
                backgroundColor: primaryColor(context),
                appBar: AppBarDefault(title: 'Dashboard'),
                body: StaggeredGridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  padding: EdgeInsets.only(left: 16, right: 16, top: 30),
                  children: <Widget>[
                    DashboardTileItemFull(
                      title: 'Connections',
                      subTitle: '265',
                      iconData: Icons.account_tree,
                      iconDataColor: dashboardFirstTileCardIconColor(context),
                    ),
                    DashboardTileItemFull(
                      title: 'Network Addresses',
                      subTitle: '2',
                      iconData: Icons.network_wifi,
                      iconDataColor: dashboardSecondTileCardIconColor(context),
                    ),
                    DashboardTileItemHalf(
                      title: 'Settings',
                      subTitle: 'Set up connection',
                      iconData: Icons.settings_applications,
                      iconDataColor: dashboardThirdTileCardIconColor(context),
                    ),
                    DashboardTileItemHalf(
                      title: 'Databases',
                      subTitle: 'Manage access',
                      iconData: Icons.pie_chart,
                      iconDataColor: dashboardForthTileCardIconColor(context),
                    ),
                    MaterialTile(child: BarChartThickMeasurement())
                  ],
                  staggeredTiles: [
                    StaggeredTile.extent(2, 110.0),
                    StaggeredTile.extent(2, 110.0),
                    StaggeredTile.extent(1, 180.0),
                    StaggeredTile.extent(1, 180.0),
                    StaggeredTile.extent(2, 500.0),
                  ],
                )),
            BottomMenuPage(),
          ]),
        ),
      ),
      floatingActionButton: FloatingDarkLightModeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
