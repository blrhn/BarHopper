import 'env.dart';

abstract final class ApiConfig {
  static const baseUrl = "https://api.geoapify.com";
  static const placesApi = "/v2/places?";
  static const geocodeApi = "/v1/geocode/search?";
  static const categories = "catering.pub,catering.bar,catering.taproom";
  static const biasProximity = "proximity:";
  static const filterCircle = "circle:";
  static const type = "city";
  static const unitDivider = 1000;

  static Map<String, dynamic> pubQuery({
    required String coords,
    String? limit,
    String? filter,
  }) {
    final query = {
      "categories": ApiConfig.categories,
      "bias": ApiConfig.biasProximity + coords,
      "apiKey": Env.placesApi,
    };

    if (limit != null) {
      query["limit"] = limit;
    }

    if (filter != null) {
      query["filter"] = "$filterCircle$coords,$filter";
    }

    return query;
  }

  static Map<String, dynamic> cityQuery({required String city}) {
    return {"text": city, "type": type, "apiKey": Env.placesApi};
  }
}
