import 'package:flutter/material.dart';

// Configuration du thème personnalisé
class AppTheme {
  // Couleurs de la charte graphique
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFB00020);
  static const Color onPrimaryColor = Color(0xFFFFFFFF);
  static const Color onSecondaryColor = Color(0xFF000000);
  static const Color onBackgroundColor = Color(0xFF000000);
  static const Color onSurfaceColor = Color(0xFF000000);
  static const Color onErrorColor = Color(0xFFFFFFFF);

  // Schéma de couleurs
  static const ColorScheme colorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundColor,
    surface: surfaceColor,
    error: errorColor,
    onPrimary: onPrimaryColor,
    onSecondary: onSecondaryColor,
    onBackground: onBackgroundColor,
    onSurface: onSurfaceColor,
    onError: onErrorColor,
  );

  // Typographie personnalisée
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: onBackgroundColor,
    ),
    // Le reste du TextTheme identique à votre code original...
  );

  // Thème principal de l'application
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Roboto',
      // Configuration des composants comme appBarTheme, buttonThemes, etc.
    );
  }

  // Thème sombre (optionnel)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: Color(0xFF121212),
        surface: Color(0xFF1E1E1E),
        error: Color(0xFFCF6679),
      ),
      textTheme: textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }
}
