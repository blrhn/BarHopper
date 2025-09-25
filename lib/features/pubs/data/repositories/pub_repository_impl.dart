import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/config/api_config.dart';
import '../../domain/entities/pub.dart';
import '../../domain/repositories/pub_repository.dart';
import '../models/pub_response.dart';

class PubRepositoryImpl implements PubRepository {
  final Dio _dio;

  const PubRepositoryImpl(this._dio);

  @override
  Future<List<Pub>> getNearestPubs(LatLng coords, int limit) async {
    final coordsString = _convertCoords(coords);
    final limitString = limit.toString();

    final response = await _dio.get<Map<String, dynamic>>(
      ApiConfig.placesApi,
      queryParameters: ApiConfig.pubQuery(
        coords: coordsString,
        limit: limitString,
      ),
    );

    final locationsResponse = PubResponse.fromJson(response.data!);

    return _getPub(locationsResponse);
  }

  @override
  Future<List<Pub>> getNearestPubsWithinRadius(
    LatLng coords,
    int radius,
  ) async {
    final coordsString = _convertCoords(coords);
    final radiusString = (radius * ApiConfig.unitDivider).toString();

    final response = await _dio.get<Map<String, dynamic>>(
      ApiConfig.placesApi,
      queryParameters: ApiConfig.pubQuery(
        coords: coordsString,
        filter: radiusString,
      ),
    );

    final locationsResponse = PubResponse.fromJson(response.data!);

    return _getPub(locationsResponse);
  }

  String _convertCoords(LatLng coords) {
    return "${coords.longitude},${coords.latitude}";
  }

  List<Pub> _getPub(PubResponse response) {
    return response.features
        .where((feature) => feature.properties.name != null)
        .map((feature) {
          final props = feature.properties;
          return Pub(
            distance: props.distance != null
                ? props.distance! / ApiConfig.unitDivider
                : null,
            name: props.addressLine1,
            address: props.addressLine2,
            coords: LatLng(props.lat!, props.lon!),
            phoneNumber: props.contact?.phone,
          );
        })
        .toList();
  }
}
