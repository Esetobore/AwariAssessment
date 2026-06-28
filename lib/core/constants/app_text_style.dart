import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Font families fall back gracefully to system fonts until the local
/// font assets described in pubspec.yaml are added.

abstract final class AppTextStyle {
  static const String _serif = 'CormorantGaramond'; // fallback: Georgia
  static const String _sans = 'DMSans'; // fallback: platform default

  // Brand / Display

  /// App bar wordmark.
  static const TextStyle brandName = TextStyle(
    fontFamily: _serif,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.textPrimary,
  );

  /// Large brand overlay on the carousel hero image.
  static const TextStyle heroBrandOverlay = TextStyle(
    fontFamily: _serif,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: 3,
    color: AppColors.textOnDark,
  );

  /// "TRENDY COLLECTION" — entry-screen headline.
  static const TextStyle heroHeadline = TextStyle(
    fontFamily: _sans,
    fontSize: 46,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  // Product grid

  static const TextStyle productName = TextStyle(
    fontFamily: _sans,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: AppColors.textPrimary,
  );

  static const TextStyle productPrice = TextStyle(fontFamily: _sans, fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  // Product detail

  static const TextStyle productDetailName = TextStyle(
    fontFamily: _sans,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static const TextStyle productDetailPrice = TextStyle(fontFamily: _sans, fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static const TextStyle productDescription = TextStyle(
    fontFamily: _sans,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: AppColors.textSecondary,
  );

  // Labels / Chips

  static const TextStyle chipLabel = TextStyle(fontFamily: _sans, fontSize: 13, fontWeight: FontWeight.w500);

  static const TextStyle sizeLabel = TextStyle(fontFamily: _sans, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.2);

  static const TextStyle sectionLabel = TextStyle(
    fontFamily: _sans,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    color: AppColors.textSecondary,
  );

  static const TextStyle searchHint = TextStyle(fontFamily: _sans, fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary);

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: _sans,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );
}
