import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/widgets/app_bar_default.dart';
import 'package:flutter_auth/core/widgets/line_chart_item.dart';
import 'package:flutter_auth/features/database_access/presentation/pages/database_access_page.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard_chart.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/dashboard/get_dashboard_charts.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/dashboard/get_dashboard_data.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/settings_page.dart';
import 'package:flutter_auth/features/homepage/presentation/widgets/dashboard_tile_item_full.dart';
import 'package:flutter_auth/features/homepage/presentation/widgets/dashboard_tile_item_half.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/bar_chart_thick_measurement.dart';
import 'package:flutter_auth/features/metric_charts/presentation/widgets/line_chart_measurement.dart';
import 'package:flutter_auth/features/shared/presentation/common/menu_functions.dart';
import 'package:flutter_auth/features/shared/presentation/pages/bottom_menu_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatelessWidget {
  final GetDashboardData getDashboardData = injector<GetDashboardData>();
  final GetDashboardCharts getDashboardCharts = injector<GetDashboardCharts>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait<Object>(
          [getDashboardData(NoParams()), getDashboardCharts(NoParams())]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return DashboardItems();
        }

        Dashboard dashboardData;
        List<DashboardChart> dashboardCharts = [];

        snapshot.data[0].fold((failure) {}, (dashboard) {
          dashboardData = dashboard;
        });

        if (snapshot.data[1] != null) {
          dashboardCharts = snapshot.data[1];
        }

        return DashboardItems(
            dashboardData: dashboardData, dashboardCharts: dashboardCharts);
      },
    );
  }
}

class DashboardItems extends StatelessWidget {
  final Dashboard dashboardData;
  final List<DashboardChart> dashboardCharts;

  const DashboardItems({
    Key key,
    this.dashboardData,
    this.dashboardCharts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<MeasurementBloc>(),
      child: Scaffold(
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
                        title: 'Number of accesses',
                        subTitle: getNumAccessData(),
                        iconData: Icons.network_wifi,
                        iconDataColor: dashboardFirstTileCardIconColor(context),
                      ),
                      DashboardTileItemFull(
                        title: 'Database users',
                        subTitle: getNumDBData(),
                        iconData: Icons.supervised_user_circle_outlined,
                        iconDataColor:
                            dashboardSecondTileCardIconColor(context),
                      ),
                      DashboardTileItemHalf(
                        title: 'Settings',
                        subTitle: 'Set up connection',
                        iconData: Icons.settings_applications,
                        redirectTo: SettingsPage(),
                        iconDataColor: dashboardThirdTileCardIconColor(context),
                      ),
                      DashboardTileItemHalf(
                        title: 'Databases',
                        subTitle: 'Manage access',
                        redirectTo: DatabaseAccessPage(),
                        iconData: Icons.pie_chart,
                        iconDataColor: dashboardForthTileCardIconColor(context),
                      ),
                      ...(dashboardCharts != null
                          ? (dashboardCharts
                              .map((e) => buildDashboardChart(e))
                              .toList())
                          : [])
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(2, 110.0),
                      StaggeredTile.extent(2, 110.0),
                      StaggeredTile.extent(1, 170.0),
                      StaggeredTile.extent(1, 170.0),
                      ...(dashboardCharts != null
                          ? (dashboardCharts
                              .map((e) => StaggeredTile.extent(2, 550.0))
                              .toList())
                          : []),
                      StaggeredTile.extent(1, 40.0),
                    ],
                  )),
              BottomMenuPage(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildDashboardChart(DashboardChart e) {
    if (e.title == 'Connections')
      return BarChartThickMeasurement(
          title: e.title, measurement: e.measurement);
    else if (e.title == 'Logical Size')
      return LineChartMeasurement(
          title: e.title, type: LineChartType.Thin, measurement: e.measurement);
    else
      return LineChartMeasurement(
          title: e.title,
          type: LineChartType.Thick,
          measurement: e.measurement);
  }

  String getNumAccessData() {
    if (dashboardData != null && dashboardData.numAccess != null) {
      return dashboardData.numAccess.totalCount.toString();
    }

    return '--';
  }

  String getNumDBData() {
    if (dashboardData != null && dashboardData.numDbUsers != null) {
      return dashboardData.numDbUsers.totalCount.toString();
    }

    return '--';
  }
}
