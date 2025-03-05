import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/core/DI/dependacy_injection.dart';
import 'package:graduation_project/nabta_app.dart';

import 'core/routing/app_router.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpGetIt();

  // علشان الابليكيشن ميلفش وشريط الحالة اللي فوق يبقا شفاف
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(NabtaApp(
    appRouter: AppRouter(),
  ));
}
