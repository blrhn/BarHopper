import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/location.dart';

part "location_provider.g.dart";

// TODO: examine: E/FlutterGeolocator(22119): There is still another flutter engine connected, not stopping location service error
@Riverpod(keepAlive: true)
Stream<LatLng?> userLocation(Ref ref) {
  return Location.currentCoordsListener();
}
