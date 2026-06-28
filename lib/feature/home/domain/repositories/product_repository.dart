import '../entities/product.dart';

/// Data-access contract for the product catalogue.
/// The presentation layer depends only on this interface.
///

abstract interface class ProductRepository {
  /// Returns every product regardless of category.
  List<Product> getAll();

  /// Filters by [category].  If [category] == 'Trending' the full list
  /// is returned so the "Trending" chip acts as a "show all" control.
  List<Product> getByCategory(String category);
}
