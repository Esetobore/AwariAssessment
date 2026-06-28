import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/size_utils.dart';
import '../../domain/entities/product.dart';

/// Product grid card displayed in the 2-column [SliverGrid] on HomeScreen.
///
/// Tapping the card body navigates to [ProductScreen].
/// Tapping the heart icon toggles the liked state via [onLike]; the icon
/// animates between outlined and filled using [AnimatedSwitcher].

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isLiked;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.isLiked, required this.onLike, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
          boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 14, offset: Offset(0, 4))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Product image + heart overlay ──────────────────
              Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(product.primaryImage, fit: BoxFit.cover),
                    Positioned(
                      top: getVerticalSize(10, context),
                      right: getHorizontalSize(10, context),
                      child: _HeartButton(isLiked: isLiked, onTap: onLike),
                    ),
                  ],
                ),
              ),
              // ── Name + price ───────────────────────────────────
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    getHorizontalSize(12, context),
                    getVerticalSize(10, context),
                    getHorizontalSize(12, context),
                    getVerticalSize(10, context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(product.name, style: AppTextStyle.productName, maxLines: 2, overflow: TextOverflow.ellipsis),
                      SizedBox(height: getVerticalSize(3, context)),
                      Text(product.formattedPrice, style: AppTextStyle.productPrice),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Heart button ──────────────────────────────────────────────────────────

class _HeartButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const _HeartButton({required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Expanded hit area
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: getHorizontalSize(34, context),
        height: getVerticalSize(34, context),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: Tween<double>(begin: 0.6, end: 1).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            key: ValueKey(isLiked),
            size: getFontSize(17, context),
            color: isLiked ? AppColors.heartLiked : AppColors.heartUnliked,
          ),
        ),
      ),
    );
  }
}
