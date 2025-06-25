import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/disease_detection/logic/disease_cubit.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/camera_screen.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/image_preview_screen.dart';
import 'package:graduation_project/features/disease_detection/ui/screen/result_done.dart';
import 'package:graduation_project/features/forget_password/logic/send_forget_password_cubit.dart';
import 'package:graduation_project/features/forget_password/ui/email_checked.dart';
import 'package:graduation_project/features/forget_password/ui/forget_password.dart';
import 'package:graduation_project/features/forget_password/ui/new_pass_assign.dart';
import 'package:graduation_project/features/forget_password/ui/reset_password_done.dart';
import 'package:graduation_project/features/home/logic/user_data_cubit.dart';
import 'package:graduation_project/features/home/ui/home_screen.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/login_screen.dart';
import 'package:graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:graduation_project/features/plant/data/model/plant_response.dart';
import 'package:graduation_project/features/plant/logic/plant_cubit.dart';
import 'package:graduation_project/features/plant/ui/screens/plant_report.dart';
import 'package:graduation_project/features/plant/ui/screens/plant_screen.dart';
import 'package:graduation_project/features/report/logic/report_cubit.dart';
import 'package:graduation_project/features/report/ui/screens/first_report_screen.dart';
import 'package:graduation_project/features/report/ui/screens/second_report_screen.dart';
import 'package:graduation_project/features/report/ui/widgets/done_report.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/screens/first_password_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/first_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/image_upload.dart';
import 'package:graduation_project/features/signup/ui/screens/otp_screen.dart';
import 'package:graduation_project/features/signup/ui/screens/second_signup.dart';
import 'package:graduation_project/features/splash/ui/splash_screen.dart';
import 'package:graduation_project/features/weather/logic/weather_cubit.dart';
import 'package:graduation_project/features/welcoming/welcomingScreen.dart';

import '../../features/animal/data/model/animal_response.dart';
import '../../features/animal/logic/animal_cubit.dart';
import '../../features/animal/ui/screens/animal_report.dart';
import '../../features/animal/ui/screens/animal_screen.dart';

class AppRouter {
  final getIt = GetIt.instance;

  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routing.splashScreen:
        return createRoute(const SplashScreen());

      case Routing.onBoarding:
        return createRoute(OnboardingScreen());

      case Routing.loginScreen:
        return createRoute(
          BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routing.signupScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const FirstSignup(),
          ),
        );

      case Routing.secondSignUpScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const SecondSignup(),
          ),
        );

      case Routing.firstPasswordSignupScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const FirstPasswordSignup(),
          ),
        );

      case Routing.uploadingImageScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const UploadingImageScreen(),
          ),
        );

      case Routing.otpScreen:
        return createRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<ActiveCodeCubit>(),
              ),
              BlocProvider.value(
                value: getIt<SignupCubit>(),
              ),
            ],
            child: const OTPScreen(),
          ),
        );

      case Routing.forgetPasswordScreen:
        return createRoute(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<SendForgetPasswordCubit>(),
            ),
          ],
          child: const ForgetPasswordScreen(),
        ));

      case Routing.emailCheckedScreen:
        return createRoute(const EmailChecked());

      case Routing.newPasswordScreen:
        return createRoute(const NewPassAssign());

      case Routing.resetPasswordDoneScreen:
        return createRoute(ResetPassDone());

      case Routing.welcomingScreen:
        return createRoute(const Welcom());

      // report Screens
      case Routing.firstReportScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<ReportCubit>(),
            child: FirstReportScreen(),
          ),
        );

      case Routing.secondReportScreen:
        return createRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider<UserDataCubit>(
                create: (context) => getIt<UserDataCubit>(),
              ),
              BlocProvider<ReportCubit>(
                create: (context) => getIt<ReportCubit>(),
              ),
            ],
            child: SecondReportScreen(),
          ),
        );

      case Routing.doneReportScreen:
        return createRoute(DoneReport());

      case Routing.plantScreen:
        return createRoute(BlocProvider(
          create: (context) => getIt<PlantCubit>(),
          child: const PlantsScreen(),
        ));

      case Routing.plantReport:
        if (arguments is Data) {
          return createRoute(
            BlocProvider.value(
              value: getIt<PlantCubit>(),
              child: PlantReport(
                plantData: arguments,
              ),
            ),
          );
        }
        return createRoute(
            const Center(child: Text("حدث خطأ في تحميل بيانات النبات")));

      case Routing.animalScreen:
        return createRoute(BlocProvider(
          create: (context) => getIt<AnimalCubit>(),
          child: const AnimalScreen(),
        ));

      case Routing.animalReport:
        if (arguments is Animal) {
          return createRoute(
            BlocProvider.value(
              value: getIt<AnimalCubit>(),
              child: AnimalReport(
                animalData: arguments,
              ),
            ),
          );
        }
        return createRoute(
            const Center(child: Text("حدث خطأ في تحميل بيانات الحيوان")));

      case Routing.cameraScreen:
        return createRoute(BlocProvider.value(
          value: getIt<DiseaseCubit>(),
          child: CameraScreen(),
        ));

      case Routing.imagePreviewScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<DiseaseCubit>(),
            child: ImagePreviewScreen(),
          ),
        );

      case Routing.resultImageDetection:
        return createRoute(BlocProvider.value(
          value: getIt<DiseaseCubit>(),
          child: ResultScreen(),
        ));

      case Routing.homeScreen:
        return createRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider<WeatherCubit>(
                create: (context) => getIt<WeatherCubit>(),
              ),
              BlocProvider<UserDataCubit>(
                create: (context) => getIt<UserDataCubit>(),
              ),
            ],
            child: const Home(),
          ),
        );

      default:
        return createRoute(const Column());
    }
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}
