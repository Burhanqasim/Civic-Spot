import 'dart:io';

import 'package:civicspot/core/routes/app_routes.dart';
import 'package:civicspot/features/home/model/issue_model.dart';
import 'package:civicspot/features/home/repository/issue_repository.dart';
import 'package:civicspot/features/report/repositories/storage_repository.dart';
import 'package:civicspot/services/location_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ReportControllers extends GetxController{
  final IssueRepository _issueRepository = Get.find<IssueRepository>();
  final StorageRepository _storageRepository = Get.find<StorageRepository>();
  final LocationServices _locationServices = Get.find<LocationServices>();
  final titleController = TextEditingController();
  final descriptiveController = TextEditingController();
  final RxString selectedCategory = "Pothole".obs;
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxBool isLoading = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

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
   final pos = _locationServices.currentPosition.value;
   if(pos != null){
     selectedLocation.value = LatLng(pos.latitude, pos.longitude);
   }
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    titleController.dispose();
    descriptiveController.dispose();
    super.onClose();
  }

  // void _loadCurrentLocation(){
  //   final position = _locationServices.currentPosition.value;
  //   if(position != null){
  //     selectedLocation.value = LatLng(position.latitude, position.longitude);
  //   }
  // }

  void openLocationPicker() async {
    // Navigation
    final dynamic result = await Get.toNamed(
        AppRoutes.pickLocation,
        arguments: selectedLocation.value
    );
    if(result != null && result is LatLng){
      selectedLocation.value = result;
    }

  }

  void setCategory(String category){
    selectedCategory.value = category;
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70); // compress slightly to save storage space
    if(pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }


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
      // generate UUID
      final String issueId = FirebaseFirestore.instance.collection("issues").doc().id;

      // upload image to Storage
      String? imageUrl;

      if(selectedImage.value != null) {
        imageUrl = await _storageRepository.uploadIssueImage(selectedImage.value!, issueId);

      }

      final issue = IssueModel(
          id: issueId,
          title: title,
          description: description,
          category: selectedCategory.value,
          latitude: location.latitude,
          longitude: location.longitude,
          status: "pending",
          userId: "Guest_User",
          imageUrl: imageUrl,
          createdAt: DateTime.now());
      await _issueRepository.addIssue(issue);
      Get.back();
      Get.snackbar("Success", "Issue report successfully", backgroundColor:  Colors.green, colorText: Colors.white);
    } catch(e) {
      Get.snackbar("Error", "Failed to submit issue", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }


  }
 }