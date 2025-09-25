import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pub.dart';
import 'pub_repository_provider.dart';

part "pub_provider.g.dart";

@riverpod
Future<List<Pub>> nearestPubs(Ref ref, LatLng coords, int limit) async {
  final repository = ref.read(pubRepositoryProvider);

  return repository.getNearestPubs(coords, limit);
}

@riverpod
Future<List<Pub>> nearestPubsWithRadius(
  Ref ref,
  LatLng coords,
  int radius,
) async {
  final repository = ref.read(pubRepositoryProvider);

  return repository.getNearestPubsWithinRadius(coords, radius);
}
