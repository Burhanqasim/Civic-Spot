import 'package:civicspot/features/issue_detail/controllers/issue_detail_controllers.dart';
import 'package:get/get.dart';

class IssueDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssueDetailControllers>(()=> IssueDetailControllers(),);
  }

}