import 'package:flutter/material.dart';

/// 🎨 Editorial design system — warm graphite + champagne accents.
class AppColors {
  // Backgrounds (warm graphite, not blue)
  static const Color darkNavy = Color(0xFF0D0D10); // page background
  static const Color navy = Color(0xFF111114); // section gradient mid
  static const Color lightNavy = Color(0xFF18181D); // cards / raised surfaces

  // Text (warm neutrals)
  static const Color white = Color(0xFFF5F3EE);
  static const Color lightSlate = Color(0xFFE6E3DC); // headings
  static const Color slate = Color(0xFFA3A099); // body

  // Accents — champagne / bronze + muted mist blue
  static const Color gold = Color(0xFFC9A96B);
  static const Color bronze = Color(0xFF9A7B45);
  static const Color mist = Color(0xFF93A6BB);
  static const Color mint = Color(0xFF93BFA0); // status green (soft sage)

  /// Subtle champagne-foil gradient (used sparingly).
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFD9BC85), gold, Color(0xFFA9885A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Soft end-of-range accent used for small labels & numbers.
  static const Color accent = gold;
}
