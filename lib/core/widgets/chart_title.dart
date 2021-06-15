import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class ChartTitle extends StatelessWidget {
  const ChartTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Chart',
      style: TextStyle(
          color: chartTextsColor(context),
          fontSize: 24,
          fontWeight: FontWeight.bold),
    );
  }
}
