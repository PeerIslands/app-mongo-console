import 'dart:convert';

import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard_chart.dart';

class GetDashboardCharts
    implements UseCaseWithoutEither<List<DashboardChart>, NoParams> {
  @override
  Future<List<DashboardChart>> call(NoParams params) async {
    List<DashboardChart> list = [];

    var json = await ApiBaseHelper.storage.read(key: 'pinnedCharts');

    if (json != null) {
      var jsonDashCharts = jsonDecode(json);

      return ((jsonDashCharts as List)
          .map((measurement) => DashboardChart.fromJson(measurement))
          .toList());
    }

    return list;
  }
}
