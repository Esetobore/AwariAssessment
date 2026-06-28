import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_style.dart';
import '../../../../core/navigation/route_enum.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../../../../shared/widgets/custom_icon_button.dart';
import '../../data/datasource/product_local_datasource.dart';
import '../../data/repositoryImpl/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../providers/home_provider.dart';
import '../widgets/category_chip_widget.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeProvider _provider;
  int _navIndex = 0;

  @override
  void initState() {
    super.initState();
    _provider = HomeProvider(repository: ProductRepositoryImpl(datasource: const ProductLocalDatasourceImpl()));
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void _openProduct(Product product) => Navigator.pushNamed(context, RouteEnum.product.path, arguments: product);

  @override
  Widget build(BuildContext context) {
    return HomeProviderScope(
      provider: _provider,
      child: Scaffold(
        backgroundColor: AppColors.darkScaffold,
        body: Column(
          spacing: getVerticalSize(4, context),
          children: [
            // Nav + Search
            _TopSection(provider: _provider),

            // Category strip + product grid
            Expanded(
              child: ListenableBuilder(
                listenable: _provider,
                builder: (context, _) => _ContentSection(provider: _provider, onProductTap: _openProduct),
              ),
            ),

            SizedBox(height: getVerticalSize(1, context)),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(currentIndex: _navIndex, onTap: (i) => setState(() => _navIndex = i)),
      ),
    );
  }
}

// Top section (AppBar + Search)

class _TopSection extends StatelessWidget {
  final HomeProvider provider;
  const _TopSection({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        // Fully rounded corners to match the image
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(getHorizontalSize(20, context)),
          bottomRight: Radius.circular(getHorizontalSize(20, context)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: getPadding(context: context, horizontal: 16, top: 12, bottom: 4),
              child: Row(
                children: [
                  CustomIconButton(
                    onTap: () {
                      // TODO: Open drawer
                    },
                    icon: Icons.menu_rounded,
                  ),
                  Expanded(
                    child: Center(child: Text('Lumière', style: AppTextStyle.brandName)),
                  ),
                  CustomIconButton(
                    onTap: () {
                      // TODO: Open cart
                    },
                    icon: Icons.shopping_bag_outlined,
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(context: context, horizontal: 20, top: 4, bottom: 20),
              child: const SearchBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

// Content section (Category strip + scrollable grid)

class _ContentSection extends StatelessWidget {
  final HomeProvider provider;
  final ValueChanged<Product> onProductTap;

  const _ContentSection({required this.provider, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    final products = provider.filteredProducts;
    final borderRadius = BorderRadius.circular(getHorizontalSize(20, context));

    return Container(
      decoration: BoxDecoration(color: AppColors.background, borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _categoryStrip(context)),
            if (products.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Text('No products in this category yet.', style: AppTextStyle.sectionLabel.copyWith(color: AppColors.textSecondary)),
                ),
              )
            else
              SliverPadding(
                padding: getPadding(context: context, left: 16, right: 16, top: 4, bottom: 24),
                sliver: SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: getVerticalSize(16, context),
                    crossAxisSpacing: getHorizontalSize(14, context),
                    childAspectRatio: 0.67,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final p = products[i];
                    return ProductCard(
                      product: p,
                      isLiked: provider.isLiked(p.id),
                      onLike: () => provider.toggleLike(p.id),
                      onTap: () => onProductTap(p),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _categoryStrip(BuildContext context) {
    return Padding(
      padding: getPadding(context: context, top: 10),
      child: SizedBox(
        height: getVerticalSize(54, context),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: getPadding(context: context, horizontal: 16, vertical: 8),
          physics: const BouncingScrollPhysics(),
          itemCount: HomeProvider.categories.length,
          itemBuilder: (context, i) {
            final cat = HomeProvider.categories[i];
            return CategoryChipWidget(label: cat, isSelected: provider.selectedCategory == cat, onTap: () => provider.selectCategory(cat));
          },
        ),
      ),
    );
  }
}
