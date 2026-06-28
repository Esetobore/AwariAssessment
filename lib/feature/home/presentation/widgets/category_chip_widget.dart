import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/size_utils.dart';

/// A single selectable category pill used in the horizontal filter strip.
///
/// Selected state: dark fill, white label.
/// Unselected state: white fill, dark label, light border.

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChipWidget({super.key, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(right: getHorizontalSize(8, context)),
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSize(18, context), vertical: getVerticalSize(7, context)),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.chipSelectedBg : AppColors.chipUnselectedBg,
          borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
          border: Border.all(color: isSelected ? AppColors.chipSelectedBg : AppColors.chipBorder),
        ),
        child: Text(
          label,
          style: AppTextStyle.chipLabel.copyWith(
            color: isSelected ? AppColors.textOnDark : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
