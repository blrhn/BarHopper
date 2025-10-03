import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../config/map_config.dart';

class Location {
  static Future<bool> hasLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    final permission = await Geolocator.checkPermission();

    return switch (permission) {
      LocationPermission.always || LocationPermission.whileInUse => true,
      _ => _requestPermission(),
    };
  }

  static Future<bool> _requestPermission() async {
    final permission = await Geolocator.requestPermission();

    return switch (permission) {
      LocationPermission.always || LocationPermission.whileInUse => true,
      _ => false,
    };
  }

  static Future<LatLng?> getCurrentCoords() async {
    final hasPermission = await hasLocationPermission();
    if (!hasPermission) {
      return null;
    }

    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    final position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    return LatLng(position.latitude, position.longitude);
  }

  static Stream<LatLng?> currentCoordsListener() {
    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: LocationConfig.distanceFilter,
    );

    return Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).map((position) => LatLng(position.latitude, position.longitude));
  }
}
