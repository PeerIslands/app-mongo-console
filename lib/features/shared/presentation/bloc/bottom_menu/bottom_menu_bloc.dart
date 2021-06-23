import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/features/database_access/presentation/pages/database_access_page.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/authentication_page.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/connections_chart_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/logical_size_chart_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/network_chart_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/opcounters_chart_page.dart';
import 'package:flutter_auth/features/network_access/presentation/pages/network_access_page.dart';
import 'package:flutter_auth/features/shared/domain/entities/menu_item.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_menu_event.dart';

class BottomMenuBloc extends Bloc<MenuEvent, BottomMenuState> {
  BottomMenuBloc() : super(Initial(items: _initialState()));

  static List<MenuItem> _initialState() => [
        MenuItem(Icon(Icons.home, color: Colors.white, size: 35),
            DashboardPage(), false, 'Dashboard'),
        MenuItem(Icon(Icons.stacked_bar_chart, color: Colors.white, size: 35),
            null, true, 'Metrics'),
        MenuItem(Icon(Icons.network_wifi, color: Colors.white, size: 35),
            NetworkAccessPage(), false, 'Network'),
        MenuItem(Icon(Icons.pie_chart, color: Colors.white, size: 35),
            DatabaseAccessPage(), false, 'Databases'),
        MenuItem(Icon(Icons.logout, color: Colors.white, size: 35),
            AuthenticationPage(), false, 'Logout'),
      ];

  @override
  Stream<BottomMenuState> mapEventToState(MenuEvent event) async* {
    if (event is ChartItemPressed) {
      yield ChartMenuOpened(items: [
        MenuItem(Icon(Icons.stacked_bar_chart, color: Colors.white, size: 35),
            ConnectionsChartPage(), false, 'Connections'),
        MenuItem(Icon(Icons.multiline_chart, color: Colors.white, size: 35),
            NetworkChartPage(), false, 'Network'),
        MenuItem(
            Icon(Icons.insert_chart_outlined, color: Colors.white, size: 35),
            OpcountersChartPage(),
            false,
            'Opcounters'),
        MenuItem(Icon(Icons.stacked_line_chart, color: Colors.white, size: 35),
            LogicalSizeChartPage(), false, 'Logical Size'),
      ]);
    } else if (event is CloseChartMenu) {
      yield Initial(items: _initialState());
    }
  }
}
