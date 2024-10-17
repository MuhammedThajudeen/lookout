import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

bool noNumberString(String str) {
  final regex = RegExp(r'^\D+$'); // Matches one or more non-digit characters
  return regex.hasMatch(str) && str.length <= 20 && !str.contains("Unnamed");
}

staggeredDotwaveLoading() {
  return LoadingAnimationWidget.staggeredDotsWave(
    color: Colors.blue,
    size: 35,
  );
}

Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    Uri uri = Uri.parse(googleUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }
