import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> buildMaterialDatePicker({
  BuildContext context,
  DateTimeRange initialDateRange,
  Function callback,
}) async {
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
    callback(dateRange.start, dateRange.end);
  }
}
