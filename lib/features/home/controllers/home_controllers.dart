import 'dart:async';

import 'package:civicspot/features/home/model/issue_model.dart';
import 'package:civicspot/features/home/repository/issue_repository.dart';
import 'package:civicspot/services/location_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeControllers extends GetxController{
  final LocationServices _locationServices = Get.find<LocationServices>();
  final IssueRepository _issueRepository = Get.find<IssueRepository>();

  @override
  void onInit() {
    _initLocation();
    _fetchIssues();
    super.onInit();
  }

  @override
  void onClose() {
    _issueSubscription?.cancel();
    mapController?.dispose();
    super.onClose();
  }


  // Data states
  final RxList<IssueModel> allIssues = <IssueModel>[].obs;
  final RxList<IssueModel> filteredIssues = <IssueModel>[].obs;
  final Rx<String> selectedCategory = "All".obs;
  final RxSet<Marker> markers = <Marker>{}.obs;
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
  StreamSubscription? _issueSubscription;





  //Map State
  GoogleMapController? mapController;
  final Rx<LatLng> initialPosition = const LatLng(25.364488, 68.316214).obs;


  void _initLocation(){
    ever(_locationServices.currentPosition, (position) {
      // Animate to that position
      if(position != null){
        final latLng = LatLng(position.latitude, position.latitude);
        initialPosition.value = latLng;
        // Animate to that position
        _animatePosition(latLng);
      }
    },);
  }

  void _animatePosition(LatLng position){
    if(mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
    }
  }

  void selectCategory(String category){
    selectedCategory.value == category;
    _applyFilter();
  }

  void onMapCreated(GoogleMapController controller){
    mapController = controller;
    if(_locationServices.currentPosition.value != null){
      _animatePosition(LatLng(
          _locationServices.currentPosition.value!.latitude,
          _locationServices.currentPosition.value!.latitude
      )
      );
    }
  }

  void _fetchIssues(){
     _issueSubscription = _issueRepository.getIssuesstream().listen((issue) {
      allIssues.assignAll(issue);
      // applly filter
       _applyFilter();

    },);
  }

  void _applyFilter(){
    if(selectedCategory.value == "All"){
      filteredIssues.assignAll(allIssues);
    } else {
      filteredIssues.assignAll(
          allIssues.where((issue) => issue.category == selectedCategory.value));
    }
    // build markers
    _buildMarkers();

  }

  void _buildMarkers(){
    final Set<Marker> newMarkers = {};
    for(var issue in filteredIssues){
      newMarkers.add(
        Marker(
          markerId: MarkerId(issue.id),
          position: LatLng(issue.latitude, issue.longitude),
          infoWindow: InfoWindow(title: issue.title,  snippet: issue.category),
          icon: BitmapDescriptor.defaultMarkerWithHue(getHueForCategory(issue.category)),
        )
      );
    }
    markers.assignAll(newMarkers);
  }

  double getHueForCategory(String category){
    switch(category) {
      case "Pothole":
      case "Road Damage":
        return BitmapDescriptor.hueOrange;
      case "Garbage":
      case "Sewer Overflow":
      case "Drain Blockage":
        return BitmapDescriptor.hueRed;
      case "Water Leakage":
        return BitmapDescriptor.hueAzure;
      case "Street Light":
      case "Electricity":
        return BitmapDescriptor.hueYellow;
      case "Unsage Area":
      case "Fallen Tree":
      case "Stray Animal":
        return BitmapDescriptor.hueViolet;
      default:
        return BitmapDescriptor.hueRed;
    }
     }
}