import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0F52BA); // Rich blue from the mockup for buttons
  static const Color sidebarColor = Color(0xFF0A2B5E); // Very dark blue for sidebar
  static const Color sidebarActiveColor = Color(0xFF1E40AF); // Lighter blue for active item
  static const Color sidebarIconColor = Colors.white;
  static const Color sidebarTextColor = Colors.white;
  
  static const Color backgroundColor = Color(0xFFF8FAFC); // Very light grey/blue for main bg
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF1E293B); // Slate 800
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color pendingColor = Color(0xFFF59E0B);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.outfit(color: textPrimary),
        bodyMedium: GoogleFonts.outfit(color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0)), // Slate 200 border
        ),
      ),
    );
  }
}
