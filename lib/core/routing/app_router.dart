import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/login_screen.dart';
import 'package:graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:graduation_project/features/signup/ui/screens/first_password_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/first_signup.dart';
import 'package:graduation_project/features/signup/ui/screens/image_upload.dart';
import 'package:graduation_project/features/signup/ui/screens/second_signup.dart';
import 'package:graduation_project/features/splash/ui/splash_screen.dart';

class AppRouter {
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
              child: const LoginScreen(),
              create: (context) => LoginCubit(
                    LoginRepository(ApiService()),
                  )),
        );
      case Routing.signupScreen:
        return MaterialPageRoute(builder: (context) => const FirstSignup());
      case Routing.secondSignUpScreen:
        return MaterialPageRoute(builder: (context) => const SecondSignup());

      case Routing.uploadingImageScreen:
        return MaterialPageRoute(builder: (context) => UploadingImageScreen());

      case Routing.homeScreen:
        return MaterialPageRoute(builder: (context) => const Column());

      case Routing.firstPasswordSignupScreen:
        return MaterialPageRoute(
            builder: (context) => const FirstPasswordSignup());

      default:
        return MaterialPageRoute(builder: (context) => const Column());
    }
  }
}
