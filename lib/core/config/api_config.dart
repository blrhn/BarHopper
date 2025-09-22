import 'env.dart';

abstract final class ApiConfig {
  static const baseUrl = "https://api.geoapify.com/v2/places?";
  static const categories = "catering.pub,catering.bar,catering.taproom";
  static const biasProximity = "proximity:";
  static const filterCircle = "circle:";
  static const unitDivider = 1000;

  static Map<String, dynamic> pubQuery({
    required String coords,
    required String limit,
    String? filter,
  }) {
    final query = {
      "categories": ApiConfig.categories,
      "bias": ApiConfig.biasProximity + coords,
      "limit": limit,
      "apiKey": Env.placesApi,
    };

    if (filter != null) {
      query["filter"] = filterCircle + filter;
    }

    return query;
  }
}
