import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/connections_chart_page.dart';
import 'package:flutter_auth/features/metric_charts/presentation/pages/network_chart_page.dart';
import 'package:flutter_auth/features/network_access/presentation/pages/network_access_page.dart';

import 'core/ioc/injection_container.dart' as dependency_injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.register();
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MongoDB Atlas Admin',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: NetworkAccessPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
