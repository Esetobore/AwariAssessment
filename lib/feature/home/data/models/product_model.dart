import '../../domain/entities/product.dart';

/// Data-layer representation of [Product].
///
/// Extends the domain entity so it is always a valid [Product] while
/// adding JSON/Map serialisation helpers to show how it could be if the data was remote.

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.currency,
    required super.category,
    required super.images,
    required super.availableSizes,
    required super.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      currency: (map['currency'] as String?) ?? '€',
      category: map['category'] as String,
      images: List<String>.from(map['images'] as List),
      availableSizes: List<String>.from(map['availableSizes'] as List),
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'currency': currency,
    'category': category,
    'images': images,
    'availableSizes': availableSizes,
    'description': description,
  };
}
