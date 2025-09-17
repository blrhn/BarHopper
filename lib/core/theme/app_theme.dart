import 'package:bar_hop/core/theme/app_theme_data.dart';
import 'package:bar_hop/core/theme/color_palette.dart';
import 'package:flutter/material.dart';

class AppTheme implements AppThemeData {
  @override
  ThemeData get light => ThemeData(
    primaryColor: ColorPalette.vividOrange,
    colorScheme: _colorScheme,
  );

  ColorScheme get _colorScheme {
    return ColorScheme.light(
      primary: ColorPalette.vividOrange,
      onPrimary: Colors.white,
      primaryContainer: ColorPalette.lightSoftOrange,
      onPrimaryContainer: ColorPalette.darkBrown,

      secondary: ColorPalette.saddleBrown,
      onSecondary: Colors.white,
      secondaryContainer: ColorPalette.grayOrange,
      onSecondaryContainer: ColorPalette.darkBrown,

      tertiary: ColorPalette.darkSoftOrange,
      onTertiary: ColorPalette.darkBrown,
      tertiaryContainer: ColorPalette.lightSoftOrange,
      onTertiaryContainer: ColorPalette.darkBrown,

      error: ColorPalette.strongRed,
      onError: Colors.white,
      errorContainer: ColorPalette.paleRed,
      onErrorContainer: Colors.white,

      surface: ColorPalette.mediumBrown,
      onSurface: ColorPalette.paleYellow,
      outline: ColorPalette.mediumBrown,
    );
  }
}

extension ThemeDataX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
