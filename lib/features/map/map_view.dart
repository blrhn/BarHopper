import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../core/config/map_config.dart';
import '../../core/config/ui_config.dart';
import '../../core/providers/location_provider.dart';
import '../pubs/data/providers/pub_provider.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(userLocationProvider);

    return switch (location) {
      AsyncData(:final value) =>
        value == null
            ? const Center(child: Text(UIMapConfig.nullCoordsText))
            : _MapViewValue(coords: value, limit: 10),
      AsyncError(:final error) => Text("${UIMapConfig.coordsError}$error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _MapViewValue extends ConsumerWidget {
  final LatLng coords;
  final int limit;
  const _MapViewValue({required this.coords, required this.limit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pubs = ref.watch(nearestPubsProvider(coords, 50));

    return FlutterMap(
      options: MapOptions(initialCenter: coords),
      children: [
        TileLayer(urlTemplate: MapConfig.urlTemplate),
        switch (pubs) {
          AsyncData(:final value) => MarkerLayer(
            markers: value
                .map(
                  (pub) => Marker(
                    point: pub.coords!,
                    child: const Icon(Icons.location_pin),
                  ),
                )
                .toList(),
          ),
          AsyncError(:final error) => Text("${UIMapConfig.coordsError}$error"),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ],
    );
  }
}
