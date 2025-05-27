import '../../products/data/product_repository.dart';
import '../../../../models/product_model.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<ProductModel>> call() async {
    return repository.getAllProducts();
  }
}
