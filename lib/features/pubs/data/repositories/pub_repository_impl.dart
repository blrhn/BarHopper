import 'package:bar_hop/features/pubs/data/models/pub_response.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/config/api_config.dart';
import '../../domain/entities/pub.dart';
import '../../domain/repositories/pub_repository.dart';

class PubRepositoryImpl implements PubRepository {
  final Dio _dio;

  const PubRepositoryImpl(this._dio);

  @override
  Future<List<Pub>> getNearestPubs(LatLng coords, int limit) async {
    final coordsString = "${coords.longitude},${coords.latitude}";
    final limitString = limit.toString();

    final response = await _dio.get<Map<String, dynamic>>(
      "",
      queryParameters: ApiConfig.pubQuery(
        coords: coordsString,
        limit: limitString,
      ),
    );

    final locationsResponse = PubResponse.fromJson(response.data!);

    final pubs = locationsResponse.features.map((feature) {
      final props = feature.properties;
      return Pub(
        distance: props.distance,
        name: props.addressLine1,
        address: props.addressLine2,
        coords: LatLng(props.lat!, props.lon!),
        phoneNumber: props.contact?.phone,
      );
    }).toList();

    return pubs;
  }

  @override
  Future<List<Pub>> getNearestPubsWithinRadius() {
    // TODO: implement getNearestPubsWithinRadius
    throw UnimplementedError();
  }
}
