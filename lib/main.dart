import 'package:civicspot/core/bindings/initial_bindings.dart';
import 'package:civicspot/core/routes/app_pages.dart';
import 'package:civicspot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Civic Spot',
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initialRoute,
      initialBinding: InitialBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
