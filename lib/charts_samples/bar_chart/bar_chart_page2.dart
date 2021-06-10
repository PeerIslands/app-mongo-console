import 'package:flutter/material.dart';

import '../../features/metric_charts/presentation/widgets/bar_chart_item_thin.dart';

class BarChartPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff132240),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: BarChartItemThin(),
        ),
      ),
    );
  }
}
