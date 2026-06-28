import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_local_datasource.dart';

/// Bridges [ProductRepository] and [ProductLocalDatasource].
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasource _datasource;

  const ProductRepositoryImpl({required ProductLocalDatasource datasource}) : _datasource = datasource;

  @override
  List<Product> getAll() => _datasource.getAll();

  @override
  List<Product> getByCategory(String category) {
    if (category == 'Trending') return getAll();
    return _datasource.getAll().where((p) => p.category == category).toList();
  }
}
