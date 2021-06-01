import 'package:flutter/material.dart';
import 'package:flutter_auth/core/widgets/sidebar_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/samples/bar_chart_sample2.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/samples/bar_chart_sample3.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/samples/bar_chart_sample4.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/bar_chart/samples/bar_chart_sample5.dart';

import 'samples/bar_chart_sample1.dart';

class BarChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
