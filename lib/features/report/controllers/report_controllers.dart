import 'package:civicspot/features/home/model/issue_model.dart';
import 'package:civicspot/features/home/repository/issue_repository.dart';
import 'package:civicspot/services/location_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportControllers extends GetxController{
  final IssueRepository _issueRepository = Get.find<IssueRepository>();
  final LocationServices _locationServices = Get.find<LocationServices>();
  final titleController = TextEditingController();
  final descriptiveController = TextEditingController();
  final RxString selectedCategory = "Pothole".obs;
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxBool isLoading = false.obs;

  final List<String> categories = [
    "Garbage",
    "Pothole",
    "Water leakage",
    "Sewer Overflow",
    "Broken streetlight",
    "Drain blockage",
    "Unsafe Area",
    "Fallen tree",
    "Stray Animal",
    "Electric hazard",
    "Other"
  ];

  @override
  void onInit() {
    _loadCurrentLocation();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    titleController.dispose();
    descriptiveController.dispose();
    super.onClose();
  }

  void _loadCurrentLocation(){
    final position = _locationServices.currentPosition.value;
    if(position != null){
      selectedLocation.value = LatLng(position.latitude, position.longitude);
    }
  }

  void setCategory(String category){
    selectedCategory.value = category;
  }

  // Submit Issue
  Future<void> submitReport() async {
    final title = titleController.text.trim();
    final description = descriptiveController.text.trim();
    final location = selectedLocation.value;
    if(title.isEmpty || description.isEmpty){
      Get.snackbar("Validation", "Please fill title and description");
      return;
    }
    if (location == null) {
      Get.snackbar("Location", "Current location is not available yet");
      return;
    }
    isLoading.value = true;

    try {
      final issue = IssueModel(
          id: "",
          title: title,
          description: description,
          category: selectedCategory.value,
          latitude: location.latitude,
          longitude: location.longitude,
          status: "pending",
          userId: "Guest_User",
          createdAt: DateTime.now());
      await _issueRepository.addIssue(issue);
      Get.back();
      Get.snackbar("Success", "Issue report successfully");
    } catch(e) {
      Get.snackbar("Error", "Failed to submit issue");
    } finally {
      isLoading.value = false;
    }


  }
 }