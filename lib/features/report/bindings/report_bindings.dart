import 'package:civicspot/features/home/repository/issue_repository.dart';
import 'package:civicspot/features/report/controllers/report_controllers.dart';
import 'package:get/get.dart';

class ReportBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ReportControllers>(()=> ReportControllers());
    Get.lazyPut<IssueRepository>(()=> IssueRepository());
  }

}