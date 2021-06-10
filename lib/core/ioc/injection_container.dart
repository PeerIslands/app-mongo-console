import 'package:flutter_auth/features/homepage/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_auth/features/homepage/domain/repositories/authentication_repository.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_login_form.dart';
import 'package:flutter_auth/features/homepage/domain/use_cases/authentication/send_signup_form.dart';
import 'package:flutter_auth/features/homepage/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_auth/features/metric_charts/data/datasources/process/process_cache_datasource.dart';
import 'package:flutter_auth/features/metric_charts/data/datasources/process/process_remote_datasource.dart';
import 'package:flutter_auth/features/metric_charts/data/repositories/measurement_repository_impl.dart';
import 'package:flutter_auth/features/metric_charts/domain/repositories/measurement_repository.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_measurement_data.dart';
import 'package:flutter_auth/features/metric_charts/domain/use_cases/fetch_process_data.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/measurement/measurement_bloc.dart';
import 'package:flutter_auth/features/metric_charts/presentation/bloc/process/process_bloc.dart';
import 'package:flutter_auth/features/shared/presentation/bloc/bottom_menu/bottom_menu_bloc.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> register() async {
  // Blocs
  injector.registerFactory(
      () => AuthenticationBloc(loginForm: injector(), signupForm: injector()));
  injector.registerFactory(() => BottomMenuBloc());
  injector.registerFactory(() => MeasurementBloc(injector()));
  injector.registerFactory(() => ProcessBloc(injector()));

  // Use cases
  injector.registerLazySingleton(() => SendLoginForm(injector()));
  injector.registerLazySingleton(() => SendSignupForm(injector()));
  injector.registerLazySingleton(() => FetchMeasurementData(injector()));
  injector.registerLazySingleton(() => FetchProcessData(injector()));

  // Data sources
  injector.registerLazySingleton<ProcessCacheDataSource>(
    () => ProcessCacheDataSourceImpl(),
  );

  injector.registerLazySingleton<ProcessRemoteDataSource>(
    () => ProcessRemoteDataSourceImpl(),
  );

  // Repositories
  injector.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(),
  );
  injector.registerLazySingleton<MeasurementRepository>(
    () => MeasurementRepositoryImpl(
        processCacheDataSource: injector(),
        processRemoteDataSource: injector()),
  );
}
