import 'package:civicspot/features/home/model/issue_model.dart';
import 'package:get/get.dart';

class IssueDetailControllers extends GetxController{
  late final IssueModel issue;
   @override
  void onInit() {
    if(Get.arguments != null && Get.arguments is IssueModel){
      issue = Get.arguments as IssueModel;
    } else {
      Get.back();
    }
    super.onInit();
  }
}