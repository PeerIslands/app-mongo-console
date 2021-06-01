import 'package:flutter/material.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/authentication_page.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/dashboard_page.dart';

import 'core/ioc/injection_container.dart' as dependency_injector;
import 'core/constants/colors_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: DashboardPage(),//AuthenticationPage(false),
      debugShowCheckedModeBanner: false,
    );
  }
}
