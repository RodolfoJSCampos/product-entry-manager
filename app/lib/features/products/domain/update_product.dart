import '../../products/data/product_repository.dart';
import '../../../../models/product_model.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<void> call(ProductModel product) async {
    await repository.updateProduct(product);
  }
}
