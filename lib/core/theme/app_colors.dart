import 'package:flutter/material.dart';

/// Centralized color system for the application.
///
/// Provides both light and dark palette variants, ensuring
/// consistent branding across all three domains.
class AppColors {
  AppColors._();

  // ─── Brand Colors ──────────────────────────────────────
  static const Color primary = Color(0xFF1B6AFF);
  static const Color primaryLight = Color(0xFF5A95FF);
  static const Color primaryDark = Color(0xFF0044CC);

  static const Color secondary = Color(0xFF00C9A7);
  static const Color secondaryLight = Color(0xFF5EEAD4);
  static const Color secondaryDark = Color(0xFF009B7D);

  static const Color accent = Color(0xFFFF6B35);

  // ─── Neutral Colors ────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // ─── Semantic Colors ───────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ─── Dark Theme Surface Colors ─────────────────────────
  static const Color darkSurface = Color(0xFF1E1E2C);
  static const Color darkBackground = Color(0xFF141420);
  static const Color darkCard = Color(0xFF252538);

  // ─── Light Theme Surface Colors ────────────────────────
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8F9FC);
  static const Color lightCard = Color(0xFFFFFFFF);
}
