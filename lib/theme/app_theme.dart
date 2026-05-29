import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// [seedColor] 
  static ThemeData build(Color seedColor) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    final textTheme = GoogleFonts.jetBrainsMonoTextTheme(
      TextTheme(
        displayLarge:  GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        displayMedium: GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        displaySmall:  GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        headlineLarge: GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        headlineMedium:GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        headlineSmall: GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        titleLarge:    GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        titleMedium:   GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        titleSmall:    GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        labelLarge:    GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        labelMedium:   GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        labelSmall:    GoogleFonts.jetBrainsMono(color: colorScheme.onSurface),
        bodyLarge:     GoogleFonts.urbanist(color: colorScheme.onSurface),
        bodyMedium:    GoogleFonts.urbanist(color: colorScheme.onSurface),
        bodySmall:     GoogleFonts.urbanist(color: colorScheme.onSurface),
      ),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: textTheme,
    );
  }
}