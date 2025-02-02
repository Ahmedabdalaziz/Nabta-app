import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/forget_password/logic/send_forget_password_cubit.dart';
import 'package:graduation_project/features/forget_password/ui/email_checked.dart';
import 'package:graduation_project/features/forget_password/ui/forget_password.dart';
import 'package:graduation_project/features/forget_password/ui/new_pass_assign.dart';
import 'package:graduation_project/features/forget_password/ui/reset_password_done.dart';
import 'package:graduation_project/features/home/ui/home_screen.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/login_screen.dart';
import 'package:graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:graduation_project/features/report/ui/screens/first_report_screen.dart';
import 'package:graduation_project/features/report/ui/screens/second_report_screen.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/screens/first_password_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/first_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/image_upload.dart';
import 'package:graduation_project/features/signup/ui/screens/otp_screen.dart';
import 'package:graduation_project/features/signup/ui/screens/second_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/start_screen.dart';
import 'package:graduation_project/features/splash/ui/splash_screen.dart';
import 'package:graduation_project/features/weather/logic/weather_cubit.dart';
import 'package:graduation_project/features/welcoming/welcomingScreen.dart';

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
          BlocProvider(
            create: (context) => getIt<SignupCubit>(),
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

      case Routing.uploadingImageScreen:
        return createRoute(
          BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const UploadingImageScreen(),
          ),
        );

      case Routing.otpScreen:
        return createRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SignupCubit>(),
              ),
              BlocProvider(
                create: (context) => getIt<ActiveCodeCubit>(),
              ),
            ],
            child: const OTPScreen(),
          ),
        );

      case Routing.firstPasswordSignupScreen:
        return createRoute(
          BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const FirstPasswordSignup(),
          ),
        );

      case Routing.forgetPasswordScreen:
        return createRoute(
          BlocProvider(
            create: (context) => getIt<SendForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case Routing.emailCheckedScreen:
        return createRoute(const EmailChecked());

      case Routing.newPasswordScreen:
        return createRoute(const NewPassAssign());

      case Routing.resetPasswordDoneScreen:
        return createRoute(ResetPassDone());

      case Routing.welcomingScreen:
        return createRoute(const Welcom());

      case Routing.startScreen:
        return createRoute(const StartScreen());

      case Routing.firstReportScreen:
        return createRoute(const FirstReportScreen());

      case Routing.secondReportScreen:
        return createRoute(const SecondReportScreen());

      case Routing.weatherScreen:
        return createRoute(Container());

      case Routing.homeScreen:
        return createRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<WeatherCubit>(),
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
