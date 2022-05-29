import 'package:flutter/material.dart';
import 'package:setuback/src/core/themes/text_theme.dart';

class ThemeConfig {
  static ColorScheme colorSchemeFromSeed =
      ColorScheme.fromSeed(seedColor: Colors.orange);

  static ThemeData get themeFromSeed => ThemeData.from(
        useMaterial3: true,
        colorScheme: colorSchemeFromSeed,
        textTheme: textTheme(),
      );
}
