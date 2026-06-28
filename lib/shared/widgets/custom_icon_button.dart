import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/size_utils.dart';

/// A reusable circular icon button with a soft background color.
///
/// Used for app bar actions (e.g., menu, back button, shopping bag).

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.onTap, required this.icon});

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(context: context, all: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(getHorizontalSize(20, context)), color: AppColors.accent.withValues(alpha: 0.1)),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon, color: AppColors.textPrimary, size: getFontSize(24, context)),
      ),
    );
  }
}
