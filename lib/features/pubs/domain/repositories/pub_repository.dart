import 'package:bar_hop/features/pubs/domain/entities/pub.dart';
import 'package:latlong2/latlong.dart';

abstract class PubRepository {
  Future<List<Pub>> getNearestPubs(LatLng coords, int limit);
  Future<List<Pub>> getNearestPubsWithinRadius();
}
