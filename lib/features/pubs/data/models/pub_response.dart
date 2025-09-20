import 'package:freezed_annotation/freezed_annotation.dart';

import 'feature.dart';

part "pub_response.g.dart";
part "pub_response.freezed.dart";

@freezed
abstract class PubResponse with _$PubResponse {
  const factory PubResponse({required List<Feature> features}) = _PubResponse;

  factory PubResponse.fromJson(Map<String, dynamic> json) =>
      _$PubResponseFromJson(json);
}
