import 'package:flutter_auth/features/homepage/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/authentication_repository.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_login_form.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_signup_form.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_bloc.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> register() async {
  // Bloc
  injector.registerFactory(() => AuthenticationBloc(loginForm: injector(), signupForm: injector()));
  injector.registerFactory(() => BottomMenuBloc());

  // Use cases
  injector.registerLazySingleton(() => SendLoginForm(injector()));
  injector.registerLazySingleton(() => SendSignupForm(injector()));

  // Repository
  injector.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );
}
