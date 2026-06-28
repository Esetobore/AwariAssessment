/// Core product entity used across the home and product-detail screens.
class Product {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String category;
  final List<String> images;
  final List<String> availableSizes;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.currency = '€',
    required this.category,
    required this.images,
    required this.availableSizes,
    required this.description,
  });

  /// Convenience getter — first image or empty string when the list is empty.
  String get primaryImage => images.isNotEmpty ? images.first : '';

  /// Price formatted for display, e.g. "€97".
  String get formattedPrice => '$currency${price.toInt()}';
}
