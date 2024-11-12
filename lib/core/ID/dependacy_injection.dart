import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/networking/dio_factory.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/signup/data/repo/repo_signin.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';

final getIt = GetIt.instance;

Future<GetIt> setUpGetIt() async {
  final Dio dio = DioFactory.getDio();

  // Register ApiService
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Register LoginRepo
  getIt.registerLazySingleton<LoginRepository>(
          () => LoginRepository(getIt<ApiService>()));

  // Register LoginCubit
  getIt.registerLazySingleton<LoginCubit>(
          () => LoginCubit(getIt<LoginRepository>()));

  // Register SignupRepository
  getIt.registerLazySingleton<SignupRepository>(
          () => SignupRepository(getIt<ApiService>()));

  // Register SignupCubit
  getIt.registerLazySingleton<SignupCubit>(
          () => SignupCubit(getIt<SignupRepository>()));

  return getIt;
}
