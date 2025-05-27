import '../../products/data/product_repository.dart';
import '../../../../models/product_model.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<void> call(ProductModel product) async {
    await repository.addProduct(product);
  }
}
