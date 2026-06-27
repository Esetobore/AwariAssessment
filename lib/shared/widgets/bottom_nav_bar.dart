import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// App-wide bottom navigation bar.
///
/// The active icon switches between outlined (unselected) and filled
/// (selected) variants using [AnimatedSwitcher] with a crossfade.
///
/// Currently four tabs are present to mirror the design:
/// Home · Favourites · Settings · Profile.
/// Only the Home tab drives real content in this assessment;
/// the others are structural placeholders.
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _outlinedIcons = [Icons.home_outlined, Icons.favorite_border, Icons.settings_outlined, Icons.person_outline];

  static const _filledIcons = [Icons.home, Icons.favorite, Icons.settings, Icons.person];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: AppColors.navShadow, blurRadius: 16, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _outlinedIcons.length,
              (i) => _NavItem(outlinedIcon: _outlinedIcons[i], filledIcon: _filledIcons[i], isSelected: currentIndex == i, onTap: () => onTap(i)),
            ),
          ),
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
        width: 60,
        height: 58,
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: Icon(
              isSelected ? filledIcon : outlinedIcon,
              key: ValueKey(isSelected),
              size: 24,
              color: isSelected ? AppColors.navSelected : AppColors.navUnselected,
            ),
          ),
        ),
      ),
    );
  }
}
