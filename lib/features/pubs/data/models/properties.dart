import 'package:freezed_annotation/freezed_annotation.dart';

import 'contact.dart';

part "properties.g.dart";
part 'properties.freezed.dart';

@freezed
abstract class Properties with _$Properties {
  const factory Properties({
    @JsonKey(name: "address_line1") String? addressLine1,
    @JsonKey(name: "address_line2") String? addressLine2,
    required double? lon,
    required double? lat,
    required double? distance,
    required Contact? contact,
  }) = _Properties;

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
}
