import 'package:bar_hop/features/pubs/data/providers/pub_repository_provider.dart';
import 'package:bar_hop/features/pubs/domain/entities/pub.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "pub_provider.g.dart";

@riverpod
Future<List<Pub>> nearestPubs(Ref ref, LatLng coords, int limit) async {
  final repository = ref.read(pubRepositoryProvider);

  return repository.getNearestPubs(coords, limit);
}
