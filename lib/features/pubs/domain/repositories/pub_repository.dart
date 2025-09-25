import 'package:latlong2/latlong.dart';

import '../entities/pub.dart';

abstract class PubRepository {
  Future<List<Pub>> getNearestPubs(LatLng coords, int limit);
  Future<List<Pub>> getNearestPubsWithinRadius(LatLng coords, int radius);
}
