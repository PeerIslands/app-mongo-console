import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/entities/line_chart_thick_item.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/util/common_functions.dart';
import 'package:flutter_auth/core/util/extension_functions.dart';

enum LineChartType { Thick, Thin }

class LineChartItem extends StatefulWidget {
  final List<List<LineChartThickItem>> arrayOfLines;
  final int numberOfItems;
  final LineChartType type;

  const LineChartItem(
      {Key key, this.arrayOfLines, this.numberOfItems, this.type})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LineChartItemState(
        arrayOfLines: arrayOfLines, numberOfItems: numberOfItems, type: type);
  }
}

class LineChartItemState extends State<LineChartItem> {
  final List<List<LineChartThickItem>> arrayOfLines;
  final int numberOfItems;
  final LineChartType type;

  LineChartItemState({
    this.arrayOfLines,
    this.numberOfItems,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final values =
        arrayOfLines.map((list) => list.map((e) => e.value).toList()).toList();

    var yAxisMin = values.getMinBetweenLists;
    var yAxisMax = values.getMaxBetweenLists;

    var rangeYAxis = createRange(yAxisMin, yAxisMax);

    return LineChart(
      LineChartData(
        minY: yAxisMin == yAxisMax ? 0 : yAxisMin,
        gridData: FlGridData(
          show: false,
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              List<LineTooltipItem> items = [];
              touchedSpots.forEach((element) {
                items.add(LineTooltipItem(
                    '${arrayOfLines[element.barIndex][element.x.toInt()].text}\n',
                    TextStyle(color: chartTooltipTextColor(context)),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${arrayOfLines[element.barIndex][element.x.toInt()].value.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: chartTooltipTextColor(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]));
              });

              return items;
            },
            tooltipBgColor: chartTooltipColor(context),
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => TextStyle(
              color: chartTextsColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            margin: 10,
            getTitles: (value) {
              if (value < numberOfItems)
                return arrayOfLines[0][value.toInt()].dayOfWeek.substring(0, 3);

              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            checkToShowTitle: (double minValue, double maxValue,
                SideTitles sideTitles, double appliedInterval, double value) {
              return value == 0 ||
                  (rangeYAxis.length < 2 &&
                      (value == yAxisMin || value == yAxisMax)) ||
                  rangeYAxis.contains(value);
            },
            getTextStyles: (value) => TextStyle(
              color: chartTextsColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            margin: 20,
            reservedSize: 30,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: chartTextsColor(context),
              width: 4,
            ),
            left: BorderSide(
              color: chartTextsColor(context),
              width: 4,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        lineBarsData: arrayOfLines.map((element) {
          return LineChartBarData(
            spots: [
              ...element.map((e) {
                return FlSpot(e.index.toDouble(), e.value);
              })
            ],
            colors: [getRandomColor()],
            curveSmoothness: type == LineChartType.Thin ? 0 : null,
            isCurved: type == LineChartType.Thick,
            barWidth: type == LineChartType.Thick ? 8 : 4,
            isStrokeCapRound: type == LineChartType.Thin,
            dotData: FlDotData(
              show: type == LineChartType.Thin,
            ),
            belowBarData: BarAreaData(
              show: type == LineChartType.Thin,
            ),
          );
        }).toList(),
      ),
      swapAnimationDuration: Duration(milliseconds: 250),
    );
  }
}
