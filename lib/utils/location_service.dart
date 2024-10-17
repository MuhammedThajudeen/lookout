import 'package:contactapp/utils/common_functions.dart';
import 'package:contactapp/utils/constants.dart';
import 'package:contactapp/viewmodel/common_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future getLocation() async {
  bool _serviceEnabled;
  LocationPermission _permission;

  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await Geolocator.openLocationSettings();
    if (!_serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  _permission = await Geolocator.checkPermission();
  if (_permission == LocationPermission.denied) {
    _permission = await Geolocator.requestPermission();
    if (_permission != LocationPermission.whileInUse &&
        _permission != LocationPermission.always) {
      return Future.error('Location permissions are denied.');
    }
  }
  Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  locationCoordinates["lat"] = pos.latitude;
  locationCoordinates["lng"] = pos.longitude;
  await getAddress(8.383230, 76.983566);
  return pos;
}

Future<List<Placemark>> getAddress(double lat, double lng) async {
  final locationcon loc = Get.put(locationcon());
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  if (placemarks.length > 3) {
    if (noNumberString(placemarks[0].name!)) {
      loc.setlocation(placemarks[0].name.toString());
    } else if (noNumberString(placemarks[2].name!)) {
      loc.setlocation(placemarks[2].name.toString());
    } else if (noNumberString(placemarks[3].name!)) {
      loc.setlocation(placemarks[3].name.toString());
    } else if (noNumberString(placemarks[4].name!)) {
      loc.setlocation(placemarks[4].name.toString());
    }
    for (var i = 0; i < placemarks.length; i++) {
      if (placemarks[i].postalCode != "") {
        await getDataFromPinCode(placemarks[i].postalCode.toString());
      }
    }
  }
  
  loc.update();
  return placemarks;
}

Future<void> getDataFromPinCode(String pinCode) async {
    final url = "http://www.postalpincode.in/api/pincode/$pinCode";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Status'] == 'Error') {
          // Display error message if the PIN code is invalid
        } else {
          // Parse and display details if the PIN code is valid
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final obj = postOfficeArray[0];

          District = obj['District'];

        }
      }
    } catch (e) {
      print('error');
    }
  }
