import 'package:flutter/material.dart';

import '../../../../core/utils/size_utils.dart';
import '../../core/constants/app_colors.dart';

/// Floating pill-shaped bottom navigation bar.

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _outlinedIcons = [Icons.home_outlined, Icons.favorite_border, Icons.settings_outlined, Icons.person_outline];
  static const _filledIcons = [Icons.home, Icons.favorite, Icons.settings, Icons.person];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getVerticalSize(100, context),
      decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(getHorizontalSize(20, context))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          _outlinedIcons.length,
          (i) => _NavItem(outlinedIcon: _outlinedIcons[i], filledIcon: _filledIcons[i], isSelected: currentIndex == i, onTap: () => onTap(i)),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({required this.outlinedIcon, required this.filledIcon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: getHorizontalSize(60, context),
        height: getVerticalSize(48, context),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Icon(
              isSelected ? filledIcon : outlinedIcon,
              key: ValueKey(isSelected),
              size: getSize(28, context),
              color: isSelected ? AppColors.navSelected : AppColors.navUnselected,
            ),
          ),
        ),
      ),
    );
  }
}
