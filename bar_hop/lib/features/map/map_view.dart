import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/config/map_config.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          51.509364,
          -0.128928,
        ), // Center the map over London
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: MapConfig.urlTemplate,
          subdomains: MapConfig.subdomains,
        ),
      ],
    );
  }
}
