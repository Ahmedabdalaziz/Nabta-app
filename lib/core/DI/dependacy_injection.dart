import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/features/animal/logic/animal_cubit.dart';
import 'package:graduation_project/features/disease_detection/data/remote/disease_api_service.dart';
import 'package:graduation_project/features/disease_detection/data/repo/disease_detction_repo.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_active_code_repo.dart';
import 'package:graduation_project/features/forget_password/data/repo/forget_password_repo.dart';
import 'package:graduation_project/features/forget_password/logic/send_forget_password_cubit.dart';
import 'package:graduation_project/features/home/data/remot/repo/user_data_repo.dart';
import 'package:graduation_project/features/home/logic/user_data_cubit.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/plant/data/repo/plant_repo.dart';
import 'package:graduation_project/features/plant/logic/plant_cubit.dart';
import 'package:graduation_project/features/report/data/repo/report_repo.dart';
import 'package:graduation_project/features/report/logic/report_cubit.dart';
import 'package:graduation_project/features/signup/data/repo/repo_active_code.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/weather/data/remote/weather_api_service.dart';
import 'package:graduation_project/features/weather/data/repo/weather_repo.dart';
import 'package:graduation_project/features/weather/logic/weather_cubit.dart';

import '../../features/animal/data/repo/animal_repo.dart';

final getIt = GetIt.instance;

Future<GetIt> setUpGetIt() async {
  // Register Dio
  getIt.registerSingleton<Dio>(DioFactory.getDio());

  // Register ApiService
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  /////////////////////////////////////////////////////////////////////

  // Register LoginRepo as Singleton
  getIt.registerSingleton<LoginRepository>(
    LoginRepository(getIt<ApiService>()),
  );

  // Register LoginCubit as Factory
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepository>()),
  );

  /////////////////////////////////////////////////////////////////////
  // Register User Data as Singleton
  getIt.registerSingleton<UserDataRepo>(
    UserDataRepo(getIt<ApiService>()),
  );

  // Register LoginCubit as Factory
  getIt.registerFactory<UserDataCubit>(
    () => UserDataCubit(getIt<UserDataRepo>()),
  );

  /////////////////////////////////////////////////////////////////////

  // Register SignupRepository as Singleton
  getIt.registerSingleton<SignupRepository>(
    SignupRepository(getIt<ApiService>()),
  );

// Register SignupCubit as Singleton
  getIt.registerLazySingleton<SignupCubit>(
    () => SignupCubit(getIt<SignupRepository>()),
  );

  // Register ActivateAccountRepository as Singleton
  getIt.registerSingleton<ActivateAccountRepository>(
    ActivateAccountRepository(getIt<ApiService>()),
  );

  // Register ActivateAccountCubit as Factory
  getIt.registerFactory<ActiveCodeCubit>(
    () => ActiveCodeCubit(getIt<ActivateAccountRepository>()),
  );

  /////////////////////////////////////////////////////////////////////

// Register SendForgetPasswordRepo and ForgetActiveCodeRepo first
  getIt.registerSingleton<SendForgetPasswordRepo>(
    SendForgetPasswordRepo(getIt<ApiService>()),
  );
  getIt.registerSingleton<ForgetActiveCodeRepo>(
    ForgetActiveCodeRepo(getIt<ApiService>()),
  );

// Register SendForgetPasswordCubit with named parameters
  getIt.registerSingleton<SendForgetPasswordCubit>(
    SendForgetPasswordCubit(
      sendForgetPasswordRepo: getIt<SendForgetPasswordRepo>(),
      forgetActiveCodeRepo: getIt<ForgetActiveCodeRepo>(),
    ),
  );
  /////////////////////////////////////////////////////////////////////

  // Register PlantRepository as Singleton
  getIt.registerSingleton<PlantRepository>(
    PlantRepository(getIt<ApiService>()),
  );

  // Register PlantCubit as Factory
  getIt.registerFactory<PlantCubit>(
    () => PlantCubit(getIt<PlantRepository>()),
  );

  /////////////////////////////////////////////////////////////////////

  // register animal repository as Singleton
  getIt.registerSingleton(
      AnimalRepository(getIt<ApiService>())
  );

  // register animal cubit as Factory

  getIt.registerSingleton(
      AnimalCubit(getIt<AnimalRepository>())
  );

  /////////////////////////////////////////////////////////////////////

  // Register report Repo
  getIt.registerLazySingleton<ReportRepo>(
    () => ReportRepo(getIt<ApiService>()),
  );

  // Register report Cubit
  getIt.registerLazySingleton<ReportCubit>(
    () => ReportCubit(getIt<ReportRepo>()),
  );

  /////////////////////////////////////////////////////////////////////

  // Register WeatherApiService as Singleton
  getIt.registerSingleton<WeatherApiService>(
    WeatherApiService(getIt<Dio>()),
  );

  // Register WeatherRepository as Singleton
  getIt.registerSingleton<WeatherRepository>(
    WeatherRepository(getIt<WeatherApiService>()),
  );

  // Register WeatherCubit as Factory
  getIt.registerFactory<WeatherCubit>(
    () => WeatherCubit(getIt<WeatherRepository>()),
  );

  /////////////////////////////////////////////////////////////////////

  // Register PlantDiseaseApiService as Singleton
  getIt.registerSingleton<PlantDiseaseApiService>(
    PlantDiseaseApiService(getIt<Dio>()),
  );

  // Register PlantDiseaseDetectionRepository as Singleton
  getIt.registerSingleton<PlantDiseaseDetectionRepository>(
    PlantDiseaseDetectionRepository(getIt<PlantDiseaseApiService>()),
  );

  // Register DiseaseCubit as Factory
  getIt.registerSingleton<DiseaseCubit>(
    DiseaseCubit(getIt<PlantDiseaseDetectionRepository>()),
  );

  return getIt;
}
