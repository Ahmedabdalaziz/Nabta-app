import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/forget_password/ui/forget_password.dart';
import 'package:graduation_project/features/home/ui/home_screen.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/login_screen.dart';
import 'package:graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:graduation_project/features/signup/logic/code_active_cubit/active_code_cubit.dart';
import 'package:graduation_project/features/signup/logic/signup_cubit.dart';
import 'package:graduation_project/features/signup/ui/screens/first_password_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/first_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/image_upload.dart';
import 'package:graduation_project/features/signup/ui/screens/otp_screen.dart';
import 'package:graduation_project/features/signup/ui/screens/second_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/start_screen.dart';
import 'package:graduation_project/features/splash/ui/splash_screen.dart';
import 'package:graduation_project/features/weather/ui.dart';
import 'package:graduation_project/features/welcoming/welcomingScreen.dart';

class AppRouter {
  final getIt = GetIt.instance;

  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routing.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routing.onBoarding:
        return MaterialPageRoute(builder: (context) => OnboardingScreen());

      case Routing.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routing.signupScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const FirstSignup(),
          ),
        );

      case Routing.secondSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const SecondSignup(),
          ),
        );

      case Routing.uploadingImageScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: UploadingImageScreen(),
          ),
        );

      case Routing.otpScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<SignupCubit>(), // Provide the existing SignupCubit
              ),
              BlocProvider(
                create: (context) =>
                    getIt<ActiveCodeCubit>(), // Create a new ActiveCodeCubit
              ),
            ],
            child: const OTPScreen(),
          ),
        );

      case Routing.firstPasswordSignupScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const FirstPasswordSignup(),
          ),
        );

      case Routing.homeScreen:
        return MaterialPageRoute(builder: (context) => const Home());

      case Routing.WelcomingScreen:
        return MaterialPageRoute(builder: (context) => Welcom());

      case Routing.WeatherScreen:
        return MaterialPageRoute(builder: (context) =>  WeatherScreen());

      case Routing.startScreen:
        return MaterialPageRoute(builder: (context) => const StartScreen());

      case Routing.forgetPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen());

      default:
        return MaterialPageRoute(builder: (context) => const Column());
    }
  }
}
