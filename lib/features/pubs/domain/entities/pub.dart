import 'package:latlong2/latlong.dart';

class Pub {
  final String? name;
  final String? address;
  final LatLng? coords;
  final String? phoneNumber;
  final double? distance;
  final String? id;

  const Pub({
    required this.name,
    required this.address,
    required this.coords,
    required this.phoneNumber,
    required this.distance,
    required this.id,
  });
}
