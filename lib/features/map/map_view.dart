import 'package:bar_hop/features/home_view/pub_limit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../core/config/map_config.dart';
import '../../core/config/ui_config.dart';
import '../../core/providers/location_provider.dart';
import '../pubs/data/providers/pub_provider.dart';
import '../pubs/domain/entities/pub.dart';
import 'pub_card.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(userLocationProvider);
    final limit = ref.watch(pubLimitProvider);

    return switch (location) {
      AsyncData(:final value) =>
        value == null
            ? const Center(child: Text(UIMapConfig.nullCoordsText))
            : _MapViewValue(coords: value, limit: limit.toInt()),
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
    final pubs = ref.watch(nearestPubsProvider(coords, limit));

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
                    child: IconButton(
                      onPressed: () => _showDetails(context, pub),
                      icon: const Icon(Icons.location_pin),
                    ),
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

  void _showDetails(BuildContext context, Pub pub) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height:
            MediaQuery.sizeOf(context).height *
            UIMapConfig.bottomSheetHeightPercentage,
        child: PubCard(pub: pub),
      ),
    );
  }
}
