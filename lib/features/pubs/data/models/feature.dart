import 'package:freezed_annotation/freezed_annotation.dart';

import 'properties.dart';

part 'feature.g.dart';
part "feature.freezed.dart";

@freezed
abstract class Feature with _$Feature {
  factory Feature({required Properties properties}) = _Feature;

  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);
}
