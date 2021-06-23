import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/entities/bar_chart_thick_item.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class BarChartThick extends StatefulWidget {
  final List<BarChartThickItem> items;

  const BarChartThick({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BarChartThickState(items: items);
  }
}

class BarChartThickState extends State<BarChartThick> {
  final List<BarChartThickItem> items;

  int touchedIndex = -1;

  BarChartThickState({this.items});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: items.map((e) {
          return BarChartGroupData(
            x: e.index,
            barRods: [
              BarChartRodData(
                y: e.value,
                colors: e.index == touchedIndex
                    ? [chartBarSelectedColor(context)]
                    : [chartBarValueColor(context)],
                width: 22,
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  y: items.fold<double>(
                          0, (max, e) => e.value > max ? e.value : max) +
                      5,
                  colors: [chartBarColor(context)],
                ),
              )
            ],
            showingTooltipIndicators: [],
          );
        }).toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: chartTooltipColor(context),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String weekDay = items[group.x].dayOfWeek;
                return BarTooltipItem(
                  weekDay + '\n',
                  TextStyle(
                    color: chartTooltipTextColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: (rod.y).toString(),
                      style: TextStyle(
                        color: chartTooltipTextColor(context),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
          touchCallback: (barTouchResponse) {
            setState(() {
              if (barTouchResponse.spot != null &&
                  barTouchResponse.touchInput is! PointerUpEvent &&
                  barTouchResponse.touchInput is! PointerExitEvent) {
                touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
              } else {
                touchedIndex = -1;
              }
            });
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => TextStyle(
                  color: chartTextsColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              margin: 16,
              getTitles: (double value) =>
                  items[value.toInt()].dayOfWeek.substring(0, 3)),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
      ),
    );
  }
}
