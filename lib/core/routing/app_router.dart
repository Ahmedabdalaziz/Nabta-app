import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/networking/api_service.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/features/login/data/repo/login_repo.dart';
import 'package:graduation_project/features/login/logic/login_cubit.dart';
import 'package:graduation_project/features/login/ui/login_screen.dart';
import 'package:graduation_project/features/onboarding/ui/onboarding_screen.dart';
import 'package:graduation_project/features/signup/ui/first_signup.dart';
import 'package:graduation_project/features/signup/ui/second_signup.dart';
import 'package:graduation_project/features/splash/ui/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routing.splashScreen:
        return _createRoute(SplashScreen());
      case Routing.onBoarding:
        return _createRoute(OnboardingScreen());
      case Routing.loginScreen:
        return _createRoute(
          BlocProvider(
            child: const LoginScreen(),
            create: (context) => LoginCubit(
              LoginRepository(ApiService()),
            ),
          ),
        );
      case Routing.signupScreen:
        return _createRoute(const FirstSignup());
      case Routing.homeScreen:
        return _createRoute(
          const Scaffold(
            body: Text("Home Screen"),
          ),
        );
      case Routing.secondSignupScreen:
        return _createRoute(const SecondSignup());
      default:
        return _createRoute(const Column());
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        var fadeTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var scaleTween =
            Tween(begin: 0.95, end: 1.0).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }
}
