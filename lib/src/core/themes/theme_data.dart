import 'package:flutter/material.dart';

import 'text_theme.dart';

class ThemeConfig {
  static ColorScheme colorSchemeFromSeed =
      ColorScheme.fromSeed(seedColor: Colors.green);

  static ThemeData get themeFromSeed => ThemeData.from(
        useMaterial3: true,
        colorScheme: colorSchemeFromSeed,
        textTheme: textTheme(),
      );
}
