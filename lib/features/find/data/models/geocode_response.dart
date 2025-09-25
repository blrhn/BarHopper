import 'package:freezed_annotation/freezed_annotation.dart';

import 'city_feature.dart';

part "geocode_response.g.dart";
part "geocode_response.freezed.dart";

@freezed
abstract class GeocodeResponse with _$GeocodeResponse {
  const factory GeocodeResponse({required List<CityFeature> features}) =
      _GeocodeResponse;

  factory GeocodeResponse.fromJson(Map<String, dynamic> json) =>
      _$GeocodeResponseFromJson(json);
}
