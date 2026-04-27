import 'package:civicspot/core/routes/app_routes.dart';
import 'package:civicspot/features/home/bindings/home_bindings.dart';
import 'package:civicspot/features/home/view/home_view.dart';
import 'package:civicspot/features/splash/bindings/splash_bindings.dart';
import 'package:civicspot/features/splash/views/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: ()=> SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: AppRoutes.home,
        page: ()=> HomeView(),
      binding: HomeBindings(),
    ),
  ];

}