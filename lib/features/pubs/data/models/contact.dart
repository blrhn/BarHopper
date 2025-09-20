import 'package:freezed_annotation/freezed_annotation.dart';

part "contact.g.dart";
part "contact.freezed.dart";

@freezed
abstract class Contact with _$Contact {
  const factory Contact({required String? phone}) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
