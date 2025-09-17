abstract final class MapConfig {
  static const urlTemplate =
      "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}@2x.png";
  static const subdomains = ["a", "b", "c", "d"];
}

abstract final class LocationConfig {
  static const distanceFilter = 100;
}
