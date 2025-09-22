abstract final class MyAppConfig {
  static const title = "BarHopper";
}

abstract final class UIMapConfig {
  static const nullCoordsText = "Please enable location permissions";
  static const coordsError = "An error occurred while loading the coords";
  static const bottomSheetHeightPercentage = 0.3;
}

abstract final class UIPubCardConfig {
  static const symmetricEdges = 16.0;
  static const heightPercentage = 0.25;
  static const beerIconHeight = 80.0;
  static const beerIconWidth = 90.0;
  static const beerIconSize = 48.0;
  static const infoIconSize = 20.0;
  static const infoIconTextSpaceWidth = 8.0;
  static const infoIconTextSpaceHeight = 12.0;
  static const distanceRoundPlaces = 2;
  static const distanceUnit = " km";
  static const addressLine1Null = "Pub Unknown";
  static const addressLine2Null = "No address available";
  static const phoneNumberNull = "No phone number available";
  static const distanceNull = "Distance Unknown";
}

abstract final class UISettingsPanelConfig {
  static const panelTextTitle = "Search Settings";
  static const panelInfoText = "Maximum number of pubs: ";
  static const saveButtonText = "Save";
  static const panelItems = [10.0, 20.0, 30.0, 40.0, 50.0];
  static const textSliderHeight = 20.0;
}
