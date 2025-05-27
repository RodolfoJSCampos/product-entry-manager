import '../../products/data/product_repository.dart';
import '../../../../models/product_model.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<ProductModel?> call(String sku) async {
    return repository.getProduct(sku);
  }
}
