import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/helper/strings.dart';
import 'package:graduation_project/core/helper/token.dart';
import 'package:graduation_project/core/routing/routing.dart';
import 'package:graduation_project/core/theming/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _fadeOutAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _fadeInAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.fastEaseInToSlowEaseOut));
    _fadeOutAnimation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut));

    _controller.forward();

    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final token = await TokenManager().getToken();

    await Future.delayed(const Duration(seconds: 5));

    if (token != null) {
      context.pushNamedAndRemoveUntil(Routing.homeScreen,
          predicate: (route) => false);
    } else {
      context.pushNamedAndRemoveUntil(Routing.loginScreen,
          predicate: (route) => false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainGreen,
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: SvgPicture.asset(firstLogoSVG),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: FadeTransition(
                opacity: _fadeOutAnimation,
                child: SvgPicture.asset(secondLogoSVG),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
