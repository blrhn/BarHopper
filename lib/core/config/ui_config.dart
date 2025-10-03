import 'package:flutter/material.dart';

import '../database/beer_type.dart';

abstract final class MyAppConfig {
  static const title = "BarHopper";
}

abstract final class UIMapConfig {
  static const nullCoordsText = "Please enable location permissions";
  static const coordsError = "An error occurred while loading the coords: ";
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

abstract final class UISearchConfig {
  static const appBarText = "Find a bar";
  static const labelText = "City";
  static const hintText = "Search for a city";
  static const radiusText = "Radius: ";
  static const cityNullText = "Select your city first";
  static const noPostCodeText = "No Postcode";
  static const nullPubs = "No pubs found";
  static const pubsError = "An error occurred while loading the pubs: ";
  static const borderRadius = 8.0;
  static const padding = 16.0;
  static const sizedBoxHeight = 13.0;
  static const distances = [10.0, 20.0, 30.0, 40.0, 50.0];
}

abstract final class UIPubViewConfig {
  static const addVisitText = "Add a review";
  static const reviewsEmptyText = "No reviews added";
  static const pubsError = "An error occurred while loading the pubs: ";
}

abstract final class UIPubReviewCardConfig {
  static const cardMarginHorizontal = 20.0;
  static const cardMarginVertical = 8.0;
  static const cardPadding = 10.0;
  static const ratingStarSpace = 2.0;
  static const starIconSize = 20.0;
  static const notesText = "Notes: ";
}

abstract final class UIPubReviewConfig {
  static const appBarEditingText = "Edit your review";
  static const appBarNewReviewText = "Add a new review";
  static const addBeersText = "Add Beers you had: ";
  static const addNewBeerText = "Add another beer";
  static const ratingTextField = "Your overall rating: ";
  static const addBeersFontSize = 16.0;
  static final firstDate = DateTime(1980);
  static const sizedBoxheight = 8.0;
  static const reviewsHorizontalPadding = 16.0;
  static const reviewsVerticalPadding = 8.0;
  static const ratingMinValue = 1.0;
  static const ratingMaxValue = 5.0;
}

abstract final class UIBeerEntryCardConfig {
  static const paddingHorizontal = 16.0;
  static const sizedBoxWidth = 16.0;
  static const textFieldLabelText = "Your beer notes: ";
}

abstract final class UIMyBeersConfig {
  static const paddingHorizontal = 16.0;
  static const aspectRation = 1.2;
  static const sectionSpace = 1.0;
  static const centerSpaceRadius = 0.0;
  static const sizedBoxHeight = 20.0;
  static const sizedBoxWidth = 4.0;
  static const totalText = "Total: ";
  static const statsError = "An error occurred while loading the statistics: ";
  static const appBarText = "Your beer statistics";
  static const touchedRadius = 110.0;
  static const unTouchedRadius = 100.0;
  static const touchedFontSize = 16.0;
  static const untouchedFontSize = 14.0;
  static const wrapSpacing = 16.0;
  static const wrapRunSpacing = 8.0;

  static Color chartColours(BeerType beerType) {
    final colors = {
      BeerType.lager: Colors.amber,
      BeerType.ale: Colors.orange,
      BeerType.stout: Colors.brown,
      BeerType.light: Colors.green,
      BeerType.wheat: Colors.pinkAccent,
      BeerType.porter: Colors.yellow,
      BeerType.marzen: Colors.indigo,
      BeerType.dunkel: Colors.blueGrey,
      BeerType.pilsner: Colors.teal,
    };
    return colors[beerType] ?? Colors.blue;
  }
}
