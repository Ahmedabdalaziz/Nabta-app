import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/routing/app_router.dart';

import 'core/routing/routing.dart';
import 'core/theming/color.dart';

class NabtaApp extends StatelessWidget {
  final AppRouter appRouter;

  const NabtaApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorsManager.mainGreen,
          scaffoldBackgroundColor: ColorsManager.white,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorsManager.mainGreen,
            selectionColor: ColorsManager.secondGreen.withOpacity(0.5),
            selectionHandleColor: ColorsManager.mainGreen,
          ),
        ),
        initialRoute: Routing.animalScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
