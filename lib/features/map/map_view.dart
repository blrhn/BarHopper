import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config/map_config.dart';
import '../../core/config/ui_config.dart';
import '../../core/providers/location_provider.dart';

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(userLocationProvider);

    return switch (location) {
      AsyncData(:final value) =>
        value == null
            ? const Center(child: Text(UIMapConfig.nullCoordsText))
            : FlutterMap(
                options: MapOptions(initialCenter: value),
                children: [
                  // TODO: map marker
                  TileLayer(urlTemplate: MapConfig.urlTemplate),
                ],
              ),
      AsyncError(:final error) => Text("${UIMapConfig.coordsError}$error"),
      _ => Center(child: CircularProgressIndicator()),
    };
  }
}
