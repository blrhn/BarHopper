import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/config/api_config.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/city_repository.dart';
import '../models/geocode_response.dart';

class CityRepositoryImpl implements CityRepository {
  final Dio _dio;

  const CityRepositoryImpl(this._dio);

  @override
  Future<List<City>> getCities(String cityName) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConfig.geocodeApi,
      queryParameters: ApiConfig.cityQuery(city: cityName),
    );

    final geocodeResponse = GeocodeResponse.fromJson(response.data!);

    final city = geocodeResponse.features.map((feature) {
      final props = feature.properties;

      return City(
        cityDetails: props.formatted,
        postcode: props.postcode,
        placeId: props.placeId,
        coords: LatLng(props.lat!, props.lon!),
      );
    }).toList();

    return city;
  }
}
