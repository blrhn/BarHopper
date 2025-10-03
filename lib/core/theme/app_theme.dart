import 'package:flutter/material.dart';

import 'app_theme_data.dart';
import 'color_palette.dart';

class AppTheme implements AppThemeData {
  @override
  ThemeData get light => ThemeData(colorScheme: _colorScheme);

  ColorScheme get _colorScheme {
    return ColorScheme.light(
      primary: ColorPalette.warmGray,
      onPrimary: Colors.white,
      primaryContainer: ColorPalette.lightHoney,
      onPrimaryContainer: ColorPalette.deepCharcoal,

      secondary: ColorPalette.espresso,
      onSecondary: Colors.white,
      secondaryContainer: ColorPalette.coffeeYellow,
      onSecondaryContainer: ColorPalette.deepCharcoal,

      tertiary: ColorPalette.richHoney,
      onTertiary: Colors.white,
      tertiaryContainer: ColorPalette.lightHoney,
      onTertiaryContainer: ColorPalette.deepCharcoal,

      error: ColorPalette.strongRed,
      onError: Colors.white,
      errorContainer: ColorPalette.paleRed,
      onErrorContainer: ColorPalette.deepCharcoal,

      surface: ColorPalette.lightHoney,
      onSurface: ColorPalette.deepCharcoal,
      surfaceContainerHighest: ColorPalette.yellowGray,
      onSurfaceVariant: ColorPalette.mediumBrown,

      outline: ColorPalette.warmGray,
      outlineVariant: ColorPalette.deepCharcoal,

      shadow: Colors.black26,
      scrim: Colors.black54,
      inverseSurface: ColorPalette.deepCharcoal,
      onInverseSurface: ColorPalette.ivoryWhite,
      inversePrimary: ColorPalette.lightHoney,
      surfaceTint: ColorPalette.honey,
    );
  }
}

extension ThemeDataX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
