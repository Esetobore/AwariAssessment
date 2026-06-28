import 'package:flutter/widgets.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

/// Presentation-layer state owner for the home screen.
///
/// Manages:
/// • The full product catalogue.
/// • The currently selected category chip.
/// • The set of liked product IDs (toggled by the heart button).

class HomeProvider extends ChangeNotifier {
  final ProductRepository _repository;

  HomeProvider({required ProductRepository repository}) : _repository = repository {
    _loadProducts();
  }

  // State

  List<Product> _allProducts = [];
  String _selectedCategory = categories.first;
  final Set<String> _likedIds = {};

  // Static data

  static const List<String> categories = ['Trending', 'Shoes', 'Sweatshirts', 'Shirts', 'Bags'];

  // Getters

  String get selectedCategory => _selectedCategory;

  List<Product> get filteredProducts => _repository.getByCategory(_selectedCategory);

  bool isLiked(String id) => _likedIds.contains(id);

  // Actions

  void _loadProducts() {
    _allProducts = _repository.getAll();
    notifyListeners();
  }

  void selectCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleLike(String id) {
    _likedIds.contains(id) ? _likedIds.remove(id) : _likedIds.add(id);
    notifyListeners();
  }
}

// Scope for the HomeProvider.
class HomeProviderScope extends InheritedNotifier<HomeProvider> {
  const HomeProviderScope({super.key, required HomeProvider provider, required super.child}) : super(notifier: provider);

  static HomeProvider of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<HomeProviderScope>();
    assert(scope != null, 'HomeProviderScope not found in the widget tree');
    return scope!.notifier!;
  }
}
