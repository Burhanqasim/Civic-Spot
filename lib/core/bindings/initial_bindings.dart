import 'package:civicspot/services/location_services.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LocationServices>(LocationServices(), permanent: true);
  }
}