import 'package:freezed_annotation/freezed_annotation.dart';

part "city_properties.g.dart";
part "city_properties.freezed.dart";

@freezed
abstract class CityProperties with _$CityProperties {
  const factory CityProperties({
    required String? formatted,
    @JsonKey(name: "place_id") String? placeId,
    required String? postcode,
    required double? lon,
    required double? lat,
  }) = _CityProperties;

  factory CityProperties.fromJson(Map<String, dynamic> json) =>
      _$CityPropertiesFromJson(json);
}
