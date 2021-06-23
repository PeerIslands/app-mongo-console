import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth/core/widgets/chart_subtitle.dart';
import 'package:flutter_auth/core/widgets/chart_title.dart';
import 'package:flutter_auth/core/widgets/date_picker_range.dart';
import 'package:flutter_auth/core/widgets/start_end_date_range.dart';

class BarChartItemThin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartItemThinState();
}

class BarChartItemThinState extends State<BarChartItemThin> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: const Color(0xfff8f7f7),
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ChartTitle(title: 'Opcounters'),
                  SizedBox(height: 4),
                  ChartSubtitle(subtitle: 'COMMANDS/QUERIES'),
                  SizedBox(height: 4),
                  StartEndDateRange(startDate: startDate, endDate: endDate),
                  SizedBox(height: 38),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        BarChartData(
                          maxY: 20,
                          barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: Colors.black,
                                getTooltipItem: (_a, _b, _c, _d) => null,
                              ),
                              touchCallback: (response) {
                                if (response.spot == null) {
                                  setState(() {
                                    touchedGroupIndex = -1;
                                    showingBarGroups = List.of(rawBarGroups);
                                  });
                                  return;
                                }

                                touchedGroupIndex =
                                    response.spot.touchedBarGroupIndex;

                                setState(() {
                                  if (response.touchInput is PointerExitEvent ||
                                      response.touchInput is PointerUpEvent) {
                                    touchedGroupIndex = -1;
                                    showingBarGroups = List.of(rawBarGroups);
                                  } else {
                                    showingBarGroups = List.of(rawBarGroups);
                                    if (touchedGroupIndex != -1) {
                                      var sum = 0.0;
                                      for (var rod
                                          in showingBarGroups[touchedGroupIndex]
                                              .barRods) {
                                        sum += rod.y;
                                      }
                                      final avg = sum /
                                          showingBarGroups[touchedGroupIndex]
                                              .barRods
                                              .length;

                                      showingBarGroups[touchedGroupIndex] =
                                          showingBarGroups[touchedGroupIndex]
                                              .copyWith(
                                        barRods:
                                            showingBarGroups[touchedGroupIndex]
                                                .barRods
                                                .map((rod) {
                                          return rod.copyWith(y: avg);
                                        }).toList(),
                                      );
                                    }
                                  }
                                });
                              }),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff0a0a0a),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 20,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Mon';
                                  case 1:
                                    return 'Tue';
                                  case 2:
                                    return 'Wed';
                                  case 3:
                                    return 'Thu';
                                  case 4:
                                    return 'Fri';
                                  case 5:
                                    return 'Sat';
                                  case 6:
                                    return 'Sun';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  color: Color(0xff050505),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 32,
                              reservedSize: 14,
                              getTitles: (value) {
                                if (value == 0) {
                                  return '1K';
                                } else if (value == 10) {
                                  return '5K';
                                } else if (value == 19) {
                                  return '10K';
                                } else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Align(
                alignment: Alignment.topRight,
                child: ListTile(
                  trailing: Wrap(
                    spacing: 2, // space between two icons
                    children: <Widget>[
                      IconButton(
                        iconSize: 40,
                        icon: Icon(CupertinoIcons.calendar),
                        onPressed: () => buildMaterialDatePicker(
                            context: context,
                            initialDateRange:
                            DateTimeRange(start: startDate, end: endDate),
                            callback: (DateTime start, DateTime end) {
                              setState(() {
                                if (startDate != start || end != endDate) {
                                  startDate = start;
                                  endDate = end;
                                }
                              });
                            },
                            limitDays: 7),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ])),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.black.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.black.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.black.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.black.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.black.withOpacity(0.4),
        ),
      ],
    );
  }
}
