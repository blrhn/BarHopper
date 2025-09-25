import 'package:freezed_annotation/freezed_annotation.dart';

import 'city_properties.dart';

part 'city_feature.g.dart';
part "city_feature.freezed.dart";

@freezed
abstract class CityFeature with _$CityFeature {
  factory CityFeature({required CityProperties properties}) = _CityFeature;

  factory CityFeature.fromJson(Map<String, dynamic> json) =>
      _$CityFeatureFromJson(json);
}
