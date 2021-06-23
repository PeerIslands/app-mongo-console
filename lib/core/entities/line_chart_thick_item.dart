import 'base_chart_item.dart';

class LineChartThickItem extends BaseChartItem {
  final String text;

  LineChartThickItem({this.text, int index, String dayOfWeek, double value})
      : super(index, dayOfWeek, value);
}
