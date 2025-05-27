import '../../products/data/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<void> call(String sku) async {
    await repository.deleteProduct(sku);
  }
}
