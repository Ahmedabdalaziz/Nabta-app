import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/signup/data/repo/repo_active_code.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/weather/data/remote/weather_api_service.dart';
import 'package:graduation_project/features/weather/data/repo/weather_repo.dart';
import 'package:graduation_project/features/weather/logic/weather_cubit.dart';

final getIt = GetIt.instance;

Future<GetIt> setUpGetIt() async {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // Register LoginRepo
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(getIt<ApiService>()),
  );

  // Register LoginCubit
  getIt.registerLazySingleton<LoginCubit>(
    () => LoginCubit(getIt<LoginRepository>()),
  );

  // Register SignupRepository
  getIt.registerLazySingleton<SignupRepository>(
    () => SignupRepository(getIt<ApiService>()),
  );

  // Register SignupCubit
  getIt.registerLazySingleton<SignupCubit>(
    () => SignupCubit(getIt<SignupRepository>()),
  );

  // Register ActivateAccountRepository
  getIt.registerLazySingleton<ActivateAccountRepository>(
    () => ActivateAccountRepository(getIt<ApiService>()),
  );

  // Register ActivateAccountCubit
  getIt.registerLazySingleton<ActiveCodeCubit>(
    () => ActiveCodeCubit(getIt<ActivateAccountRepository>()),
  );

  // Register WeatherApiService
  getIt.registerLazySingleton<WeatherApiService>(
    () => WeatherApiService(getIt<Dio>()),
  );

  // Register WeatherRepository
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepository(getIt<WeatherApiService>()),
  );

  // Register WeatherCubit
  getIt.registerLazySingleton<WeatherCubit>(
    () => WeatherCubit(getIt<WeatherRepository>()),
  );

  return getIt;
}
