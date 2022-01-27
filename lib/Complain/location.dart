import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class Location {
  double? longitude;
  double? latitude;
  String? address;

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude;
    latitude = position.latitude;
    getAddress(latitude, longitude);
  }

  Future<void> getAddress(double? latitude, double? longitude) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latitude!.toDouble(),longitude!.toDouble());
    //print(placemark);
    Placemark place = placemark[0];
    address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place
        .postalCode}, ${place.country}';
  }
}