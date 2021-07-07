import 'dart:convert';

import 'package:flutter_auth/core/http/api_base_helper.dart';
import 'package:flutter_auth/core/use_cases/use_cases.dart';
import 'package:flutter_auth/features/homepage/domain/entities/dashboard_chart.dart';

import 'get_dashboard_charts.dart';

class AddOrRemoveDashboardChart
    implements UseCaseWithoutEither<void, DashboardChart> {
  final GetDashboardCharts getDashboardCharts;

  AddOrRemoveDashboardChart(this.getDashboardCharts);

  @override
  Future<void> call(DashboardChart params) async {
    var pinnedCharts = await getDashboardCharts(NoParams());

    if (pinnedCharts.isNotEmpty) {
      // if adding
      if (!pinnedCharts.any((element) => element.title == params.title) && !params.justRefreshDataIfPinned) {
        pinnedCharts.add(params);
      }
      // if updating
      else {
        if (params.justRefreshDataIfPinned &&
            pinnedCharts.any((element) => element.title == params.title)) {
          pinnedCharts[pinnedCharts
              .indexWhere((element) => element.title == params.title)] = params;
        }
        // if removing
        else {
          pinnedCharts.removeWhere((element) => element.title == params.title);
        }
      }

      await ApiBaseHelper.storage.write(
          key: 'pinnedCharts',
          value: jsonEncode(pinnedCharts.map((v) => v.toJson()).toList())
              .toString());
    } else {
      if (!params.justRefreshDataIfPinned) {
        await ApiBaseHelper.storage
            .write(key: 'pinnedCharts', value: jsonEncode([params]).toString());
      }
    }
  }
}
