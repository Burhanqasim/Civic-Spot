import 'package:civicspot/core/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashControllers extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.home);
}
}