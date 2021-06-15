import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> buildMaterialDatePicker(
    {BuildContext context,
    DateTimeRange initialDateRange,
    Function callback,
    int limitDays}) async {
  final dateRange = await showDateRangePicker(
    context: context,
    initialDateRange: initialDateRange,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.greenAccent,
            onPrimary: Colors.black,
            surface: Colors.greenAccent,
            onSurface: Colors.grey,
          ),
          textTheme: TextTheme(overline: TextStyle(fontSize: 7)),
          dialogBackgroundColor: Colors.lightGreen,
        ),
        child: child,
      );
    },
  );

  if (dateRange.start != null && dateRange.end != null) {
    if (limitDays != null &&
        dateRange.end.isAfter(dateRange.start.add(Duration(days: limitDays)))) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Invalid date range',
        text: 'Select an interval of maximum $limitDays days range',
      );
    } else {
      callback(dateRange.start, dateRange.end);
    }
  }
}
