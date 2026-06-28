import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/size_utils.dart';

/// Circular size-selector chip used on [ProductScreen].
///
/// Selected: dark background, white label.
/// Unselected: white background, dark label, thin border.

class SizeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeChip({super.key, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final fontSize = label.length > 2 ? 9.0 : 12.0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: getHorizontalSize(40, context),
        height: getVerticalSize(40, context),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.sizeSelectedBg : AppColors.sizeUnselectedBg,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? AppColors.sizeSelectedBg : AppColors.sizeBorder, width: 1.5),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyle.sizeLabel.copyWith(
              fontSize: getFontSize(fontSize, context),
              color: isSelected ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
