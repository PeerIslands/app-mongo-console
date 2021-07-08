import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/environment_config.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_event.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_state.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/authentication_page.dart';
import 'package:flutter_auth/features/homepage/presentation/pages/dashboard_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/ioc/injection_container.dart' as dependency_injector;
import 'core/ioc/injection_container.dart';
import 'core/util/extension_functions.dart';
import 'features/homepage/presentation/bloc/authentication/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.register();
  runApp(EasyDynamicThemeWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => injector<AuthenticationBloc>()..add(CheckUserLogged()),
        child: MaterialApp(
          title: EnvironmentConfig.APP_NAME,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: EasyDynamicTheme.of(context).themeMode,
          home: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is LoggedIn) {
                  context.pushMaterialPage(DashboardPage());
                } else if (state is LoggedOut) {
                  context.pushReplacementMaterialPage(AuthenticationPage());
                }
              },
              child: AuthenticationPage()),
          debugShowCheckedModeBanner: false,
        ),
      );
}
