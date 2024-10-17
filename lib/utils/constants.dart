import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

Color maingreenColor = const Color(0xFFCFE4D6);

Placemark currentLocation = const Placemark();
String District = '';

Map locationCoordinates = {
  "lat": 0.0,
  "lng": 0.0
};