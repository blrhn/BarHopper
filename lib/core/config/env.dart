import 'package:envied/envied.dart';

part "env.g.dart";

@Envied(path: ".env", obfuscate: true, requireEnvFile: true)
abstract class Env {
  @EnviedField(varName: "PLACES_KEY")
  static final String placesApi = _Env.placesApi;
}
