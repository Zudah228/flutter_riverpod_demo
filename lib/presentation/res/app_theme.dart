import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      listTileTheme: ListTileThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        tileColor: colorScheme.primaryContainer,
        textColor: colorScheme.onPrimaryContainer,
      ),
    );
  }

  static ThemeData get light {
    final seedColor = const ColorScheme.light().primary;

    return _base(
      ColorScheme.fromSeed(seedColor: seedColor),
    );
  }

  static ThemeData get dark {
    final seedColor = const ColorScheme.dark().primary;

    return _base(
      ColorScheme.fromSeed(seedColor: seedColor),
    );
  }
}
