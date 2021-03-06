import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class ChartTitle extends StatelessWidget {
  const ChartTitle({Key key, @required this.title, this.align})
      : super(key: key);

  final String title;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Chart',
      style: TextStyle(
          color: chartTextsColor(context),
          fontSize: 24,
          fontWeight: FontWeight.bold),
      textAlign: align ?? TextAlign.left,
    );
  }
}
