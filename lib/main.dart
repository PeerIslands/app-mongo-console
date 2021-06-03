import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/core/util/app_colors.dart';

import 'core/ioc/injection_container.dart' as dependency_injector;
import 'features/homepage/presentation/pages/dashboard_page.dart';

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
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
