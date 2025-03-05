import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/DI/dependacy_injection.dart';
import 'package:graduation_project/nabta_app.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpGetIt();
  runApp(NabtaApp(
    appRouter: AppRouter(),
  ));
}
