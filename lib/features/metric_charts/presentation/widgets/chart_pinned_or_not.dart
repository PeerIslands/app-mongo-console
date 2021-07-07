import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/ioc/injection_container.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard_chart.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/dashboard/add_dashboard_chart.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/dashboard/get_dashboard_charts.dart';
import 'package:flutter_auth/features/metric_charts/domain/entities/measurement.dart';

class ChartPinnedOrNot extends StatefulWidget {
  final String title;
  final Measurement data;

  const ChartPinnedOrNot({Key key, this.title, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ChartPinnedOrNotState(title: title, data: data);
}

class _ChartPinnedOrNotState extends State<ChartPinnedOrNot> {
  final GetDashboardCharts getDashboardCharts = injector<GetDashboardCharts>();
  final AddOrRemoveDashboardChart addOrRemoveDashboardChart =
      injector<AddOrRemoveDashboardChart>();

  final String title;
  final Measurement data;

  _ChartPinnedOrNotState({this.title, this.data});

  Future<List<DashboardChart>> _dashboardPinnedChartsList;

  @override
  void initState() {
    super.initState();
    _dashboardPinnedChartsList = getDashboardCharts(NoParams());
  }

  void addOrRemovePinnedChart() {
    setState(() {
      _dashboardPinnedChartsList = updateAndGetList();
    });
  }

  Future<List<DashboardChart>> updateAndGetList() async {
    await addOrRemoveDashboardChart(DashboardChart(
        title: title, measurement: data, justRefreshDataIfPinned: false));

    return getDashboardCharts(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DashboardChart>>(
      future: _dashboardPinnedChartsList,
      builder: (context, AsyncSnapshot<List<DashboardChart>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.any((element) => element.title == title))
            return showEmptyOrFilledStartIcon(Icon(CupertinoIcons.star_fill));
        }

        return showEmptyOrFilledStartIcon(Icon(CupertinoIcons.star));
      },
    );
  }

  IconButton showEmptyOrFilledStartIcon(Icon icon) {
    return IconButton(
        iconSize: 40, icon: icon, onPressed: () => addOrRemovePinnedChart());
  }
}
