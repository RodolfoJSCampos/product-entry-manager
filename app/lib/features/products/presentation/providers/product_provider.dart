// lib/features/products/presentation/providers/product_provider.dart
import 'package:provider/provider.dart';

import '/core/services/firestore_service.dart';
import '../../data/product_repository.dart';
import '../../domain/add_product.dart';
import '../../domain/delete_product.dart';
import '../../domain/get_all_products.dart';
import '../../domain/update_product.dart';
import '../controllers/product_controller.dart';

ChangeNotifierProvider<ProductController> productControllerProvider() {
  final firestore = FirestoreService();
  final repo = ProductRepository(firestore);

  return ChangeNotifierProvider<ProductController>(
    create: (_) => ProductController(
      addProduct: AddProduct(repo),
      getAllProducts: GetAllProducts(repo),
      deleteProduct: DeleteProduct(repo),
      updateProduct: UpdateProduct(repo),
    )..loadProducts(), // Carrega os produtos assim que for criado
  );
}
