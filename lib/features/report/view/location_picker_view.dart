import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/shared/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerView extends StatefulWidget {
  const LocationPickerView({super.key});

  @override
  State<LocationPickerView> createState() => _LocationPickerViewState();
}

class _LocationPickerViewState extends State<LocationPickerView> {
  LatLng? pickedLocation;


  @override
  void initState() {
    // TODO: implement initState
    // Get arguments from previous screen
    if(Get.arguments != null && Get.arguments is LatLng){
      pickedLocation = Get.arguments as LatLng;
    } else {
      pickedLocation = LatLng(37.42, -122.084); // Default fallBack Location
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pin Location"),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
            onPressed: ()=> Get.back(
              result: null
            ),
            icon: Icon(Icons.arrow_back)),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(
                target: pickedLocation!,
                zoom: 16
            ),
            onCameraMove: (position){
              pickedLocation = position.target;
            },
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 40,
            ),
              child: Icon(
                  Icons.location_on,
                  size: 50,
                color: AppColors.error,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.paper,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.1),blurRadius: 10),
                  ],
                ),
                child: PrimaryButton(
                    text: "Confirm Location",
                    onPressed: (){
                      Get.back(result: pickedLocation);
                    }),
              ),
          ),
        ],
      ),
    );
  }
}
