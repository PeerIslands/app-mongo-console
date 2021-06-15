import 'package:date_format/date_format.dart';

String buildFormatDate(DateTime date) => formatDate(date, [
      dd,
      '/',
      mm,
      '/',
      yyyy,
    ]);
