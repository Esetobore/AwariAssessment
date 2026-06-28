import '../../../../core/constants/app_images.dart';
import '../models/product_model.dart';

abstract interface class ProductLocalDatasource {
  List<ProductModel> getAll();
}

/// Returns the static product catalogue used throughout the assessment.

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  const ProductLocalDatasourceImpl();

  @override
  List<ProductModel> getAll() => const [
    ProductModel(
      id: 'p1',
      name: "Men's Fleece Pullover Hoodie",
      price: 97,
      category: 'Sweatshirts',
      images: AppImages.pulloverHoodie,
      availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'],
      description:
          'Celebrate the power and simplicity of the Swoosh. This warm, '
          'brushed fleece hoodie is made with some extra room through the '
          'shoulders, chest and body for easy comfort and laid-back, '
          'nostalgic style.',
    ),
    ProductModel(
      id: 'p2',
      name: "Men's Sport Jersey",
      price: 68,
      category: 'Shirts',
      images: AppImages.sportJersey,
      availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      description:
          'Engineered for performance on and off the pitch. Lightweight '
          'and breathable, this jersey keeps you cool during intense '
          'sessions while maintaining a sharp, modern silhouette.',
    ),
    ProductModel(
      id: 'p3',
      name: 'Yoga Crewneck Sweatshirt',
      price: 42,
      category: 'Sweatshirts',
      images: AppImages.yogaSweatshirt,
      availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
      description:
          'Designed for movement and comfort. This versatile crewneck '
          'transitions seamlessly from studio to street, featuring a '
          'soft, stretchy fabric that moves with you.',
    ),
    ProductModel(
      id: 'p4',
      name: "Men's Knit Fairway Cardigan",
      price: 94,
      category: 'Shirts',
      images: AppImages.knitCardigan,
      availableSizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'],
      description:
          'A classic silhouette elevated with refined knit texture. '
          'Perfect for layering or wearing solo, this cardigan brings '
          'effortless sophistication to any casual ensemble.',
    ),

    ProductModel(
      id: 'p5',
      name: 'Classic Casual Jacket',
      price: 129,
      category: 'Trending',
      images: AppImages.casualJacket,
      availableSizes: ['S', 'M', 'L', 'XL'],
      description:
          'A timeless piece for the modern wardrobe. Crafted with premium '
          'materials for durability and style in equal measure.',
    ),
    ProductModel(
      id: 'p6',
      name: 'Iconic Sneakers',
      price: 89,
      category: 'Shoes',
      images: AppImages.sneakers,
      availableSizes: ['40', '41', '42', '43', '44', '45'],
      description:
          'All-day comfort meets street-ready style. Built to take you '
          'wherever the day leads with unwavering support.',
    ),
  ];
}
