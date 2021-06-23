import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/core/util/app_colors.dart';
import 'package:flutter_auth/core/util/common_functions.dart';

class StartEndDateRange extends StatelessWidget {
  const StartEndDateRange({
    Key key,
    @required this.startDate,
    @required this.endDate,
  }) : super(key: key);

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${buildFormatDate(startDate)} - ${buildFormatDate(endDate)}',
      style: TextStyle(
          color: chartTextsColor(context),
          fontSize: 12,
          fontWeight: FontWeight.bold),
    );
  }
}
