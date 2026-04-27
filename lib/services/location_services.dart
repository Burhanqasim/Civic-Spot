import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationServices extends GetxService {
  //Reactive State Variable
  final Rx<Position?> currentPosition = Rx<Position?>(null);
  final RxBool isLocationEnabled = false.obs;
  final RxString locationError = "".obs;

  @override
  void onInit() {
    _checkPermissionAndGetLocation();
    super.onInit();
  }

  Future<void> _checkPermissionAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      locationError.value = "Location service are disabled";
      return;
    }

    final permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      final permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.deniedForever){
        locationError.value = "Location service are permanently denied";
        return;
      }
    }

    if(permission == LocationPermission.deniedForever){
      locationError.value = "Location service are permanently denied";
      return;
    }

    isLocationEnabled.value = true;

    // Get the initial position
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high)
      );

      currentPosition.value = position;

      // listen to location changes
      Geolocator.getPositionStream(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        )
      ).listen((Position position) {
        currentPosition.value = position;
      },);




    } catch(e) {
      locationError.value = "Failed to get current location";
    }




  }
}