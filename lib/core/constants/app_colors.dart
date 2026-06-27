import 'package:flutter/material.dart';

/// Central colour palette.

abstract final class AppColors {
  AppColors._();

  // Backgrounds
  /// Warm cream — the app-wide scaffold background.
  static const Color background = Color(0xFFF0EAE0);

  /// Pure white — cards, search bar, bottom nav.
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF888888);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Accent
  /// Warm terracotta — "Discover Now" CTA button fill.
  static const Color accent = Color(0xFFCBA882);

  /// Soft warm beige — "Add to cart" button fill.
  static const Color accentSoft = Color(0xFFEDE0CE);

  // Category chips
  static const Color chipSelectedBg = Color(0xFF1A1A1A);
  static const Color chipUnselectedBg = Color(0xFFFFFFFF);
  static const Color chipBorder = Color(0xFFDED6C8);

  // Size chips
  static const Color sizeSelectedBg = Color(0xFF1A1A1A);
  static const Color sizeUnselectedBg = Color(0xFFFFFFFF);
  static const Color sizeBorder = Color(0xFFDED6C8);

  // Interactive
  static const Color heartLiked = Color(0xFFFF6B35);
  static const Color heartUnliked = Color(0xFFAAAAAA);

  // Structure
  static const Color divider = Color(0xFFEBE4D8);
  static const Color cardShadow = Color(0x14000000);
  static const Color navShadow = Color(0x10000000);

  // Navigation
  static const Color navSelected = Color(0xFF1A1A1A);
  static const Color navUnselected = Color(0xFFBBB5AB);

  // Thumbnail selection ring
  static const Color thumbRing = Color(0xFF1A1A1A);
}
