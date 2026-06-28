import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../../domain/entities/product.dart';
import '../widgets/size_chip.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin {
  // Animation controllers
  late final AnimationController _entryController;

  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;

  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  // UI state
  int _selectedImageIndex = 0;
  int _selectedSizeIndex = 2;

  Product get product => widget.product;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _entryController.forward();
  }

  void _setupAnimations() {
    _entryController = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));

    final imageCurve = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.0, 0.60, curve: Curves.easeOut),
    );

    _imageFade = imageCurve;
    _imageSlide = Tween<Offset>(begin: const Offset(0, 0.07), end: Offset.zero).animate(imageCurve);

    final contentCurve = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    );

    _contentFade = contentCurve;
    _contentSlide = Tween<Offset>(begin: const Offset(0, 0.10), end: Offset.zero).animate(contentCurve);
  }

  void _selectThumbnail(int index) {
    if (_selectedImageIndex == index) return;
    setState(() => _selectedImageIndex = index);
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Dark background to bleed through the gaps
      backgroundColor: AppColors.darkScaffold,
      body: Column(
        spacing: getVerticalSize(3, context),
        children: [
          // Floating App Bar Card
          _buildAppBarCard(),

          // Floating Image Card
          Expanded(
            flex: 11,
            child: FadeTransition(
              opacity: _imageFade,
              child: SlideTransition(position: _imageSlide, child: _buildImageCard()),
            ),
          ),

          // Floating Content Card
          Expanded(
            flex: 9,
            child: FadeTransition(
              opacity: _contentFade,
              child: SlideTransition(position: _contentSlide, child: _buildContentCard()),
            ),
          ),

          // Floating Add to Cart Pill
          _buildAddToCartCard(),
          SizedBox(height: getVerticalSize(5, context)),
        ],
      ),
    );
  }

  // Custom Floating App Bar

  Widget _buildAppBarCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(getHorizontalSize(20, context)),
          bottomRight: Radius.circular(getHorizontalSize(20, context)),
        ),
      ),
      padding: getPadding(context: context, vertical: 35, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(onTap: () => Navigator.pop(context), icon: Icons.arrow_back),
          const Text('Product', style: AppTextStyle.brandName),
          CustomIconButton(
            onTap: () {
              // TODO: Open cart
            },
            icon: Icons.shopping_bag_outlined,
          ),
        ],
      ),
    );
  }

  // Image section

  Widget _buildImageCard() {
    return Container(
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(getHorizontalSize(20, context))),
      padding: getPadding(context: context, all: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Main image
          Expanded(
            flex: 4,
            child: ClipRRect(borderRadius: BorderRadius.circular(getHorizontalSize(24, context)), child: _buildMainImage()),
          ),
          SizedBox(width: getHorizontalSize(12, context)),
          // Vertical thumbnail strip
          _buildThumbnailStrip(),
        ],
      ),
    );
  }

  Widget _buildMainImage() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(-0.15, 0), end: Offset.zero).animate(animation),
            child: child,
          ),
        );
      },
      child: Image.asset(
        key: ValueKey(_selectedImageIndex),
        product.images[_selectedImageIndex],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildThumbnailStrip() {
    return SizedBox(
      width: getHorizontalSize(72, context),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: product.images.length,
        separatorBuilder: (_, _) => SizedBox(height: getVerticalSize(12, context)),
        itemBuilder: (_, i) {
          final selected = _selectedImageIndex == i;
          return GestureDetector(
            onTap: () => _selectThumbnail(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: getVerticalSize(80, context), // Taller ratio for thumbnails
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
                border: Border.all(color: selected ? AppColors.thumbRing : Colors.transparent, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(getHorizontalSize(18, context)),
                child: Image.asset(product.images[i], fit: BoxFit.cover, width: double.infinity, height: double.infinity),
              ),
            ),
          );
        },
      ),
    );
  }

  // Content section

  Widget _buildContentCard() {
    return Container(
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(getHorizontalSize(20, context))),
      padding: getPadding(context: context, left: 24, right: 24, top: 24),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNamePriceRow(),
            SizedBox(height: getVerticalSize(20, context)),
            const Text('Select size', style: AppTextStyle.sectionLabel),
            SizedBox(height: getVerticalSize(12, context)),
            _buildSizeRow(),
            SizedBox(height: getVerticalSize(20, context)),
            Text(product.description, style: AppTextStyle.productDescription),
            SizedBox(height: getVerticalSize(24, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePriceRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(product.name, style: AppTextStyle.productDetailName.copyWith(fontSize: getFontSize(22, context))),
        ),
        SizedBox(width: getHorizontalSize(12, context)),
        Text('Price: ${product.formattedPrice}', style: AppTextStyle.productDetailPrice.copyWith(fontSize: getFontSize(22, context))),
      ],
    );
  }

  Widget _buildSizeRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          product.availableSizes.length,
          (i) => Padding(
            padding: EdgeInsets.only(right: getHorizontalSize(12, context)),
            child: SizeChip(
              label: product.availableSizes[i],
              isSelected: _selectedSizeIndex == i,
              onTap: () => setState(() => _selectedSizeIndex = i),
            ),
          ),
        ),
      ),
    );
  }

  // CTA Card section

  Widget _buildAddToCartCard() {
    return SizedBox(
      width: double.infinity,
      height: getVerticalSize(90, context),
      child: Material(
        color: AppColors.accentSoft, // The light yellow/cream button color
        borderRadius: BorderRadius.circular(getHorizontalSize(20, context)),
        child: InkWell(
          onTap: () {
            // TODO: Add to cart
          },
          borderRadius: BorderRadius.circular(getHorizontalSize(40, context)),
          splashColor: AppColors.accent.withValues(alpha: 0.3),
          child: Center(
            child: Text('Add to cart', style: AppTextStyle.buttonLabel.copyWith(fontSize: getFontSize(18, context))),
          ),
        ),
      ),
    );
  }
}
