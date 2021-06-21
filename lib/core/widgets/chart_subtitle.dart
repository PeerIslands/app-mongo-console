import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

class ChartSubtitle extends StatelessWidget {
  const ChartSubtitle({Key key, @required this.subtitle, this.align})
      : super(key: key);

  final String subtitle;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle ?? '',
      style: TextStyle(
          color: chartTextsColor(context),
          fontSize: 12,
          fontWeight: FontWeight.bold),
      textAlign: align ?? TextAlign.left,
    );
  }
}
