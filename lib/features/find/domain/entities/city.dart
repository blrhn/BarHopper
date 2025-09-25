import 'package:latlong2/latlong.dart';

class City {
  final String? cityDetails;
  final String? postcode;
  final String? placeId;
  final LatLng? coords;

  const City({
    required this.cityDetails,
    required this.postcode,
    required this.placeId,
    required this.coords,
  });
}
