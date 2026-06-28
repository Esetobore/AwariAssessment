import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/size_utils.dart';

/// Decorative search bar displayed at the top of the home screen.

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search your needs',
      leading: Padding(
        padding: getPadding(context: context, horizontal: 10),
        child: Icon(Icons.search, color: AppColors.textPrimary),
      ),
      elevation: WidgetStateProperty.all(0),
      hintStyle: WidgetStateProperty.all(AppTextStyle.searchHint),
      backgroundColor: WidgetStateProperty.all(AppColors.accent.withValues(alpha: 0.1)),
    );
  }
}
