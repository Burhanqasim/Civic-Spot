import 'package:civicspot/features/home/controllers/home_controllers.dart';
import 'package:civicspot/features/home/repository/issue_repository.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeControllers>(() => HomeControllers());
    Get.lazyPut<IssueRepository>(()=> IssueRepository());
  }

}