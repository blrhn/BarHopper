import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/location.dart';

part "location_provider.g.dart";

@riverpod
Future<LatLng?> userLocation(Ref ref) {
  return Location.getCurrentCoords();
}